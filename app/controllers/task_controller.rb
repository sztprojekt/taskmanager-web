class TaskController < ApplicationController

  def index
    respond_with_data({ tasks: current_user.tasks })
  end

  def create
    begin
      name = params.require :name
      due_date = params.require :due_date
      # add_to_calendar = params[:add_to_calendar]
    rescue KeyError
      return die('Missing parameters')
    end
    task = current_user.tasks.create({ name: name, due_date: due_date })
    unless current_user.google_token.nil?
      google_calendar_service = GoogleCalendarService.new current_user
      task = google_calendar_service.create_task task
      task.save
    end
    respond_with_data({task: task})
  end

  def read
    begin
      id = params.require :id
    rescue KeyError
      return die('Missing parameters')
    end
    task = Task.find_by(id: id, user_id: current_user.id)
    return die 'Task not found' if task.nil?
    respond_with_data({task: task})
  end

  def update
    begin
      id = params.require :id
      name = params.require :name
      due_date = params.require :due_date
    rescue KeyError
      return die('Missing parameters')
    end
    task = Task.find_by(id: id, user_id: current_user.id)
    return die 'Task not found' if task.nil?
    Task.update(task.id, name: name, due_date: due_date)
    success 'Task updated successully'
  end

  def delete
    begin
      id = params.require :id
    rescue KeyError
      return die('Missing parameters')
    end
    task = Task.find_by(id: id, user_id: current_user.id)
    return die 'Task not found' if task.nil?
    task.delete
    success 'Task deleted successully'
  end

  def complite
    id = params[:task_id]
    task = Task.find id
    task
    task.status = true
    task.save
    respond_with_data({task: task})
  end

end
