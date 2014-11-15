class TaskController < ApplicationController

  def index
    respond_with_data({ tasks: current_user.tasks })
  end

  def create
    begin
      name = params.require :name
      due_date = params.require :due_date
    rescue KeyError
      return die('Missing parameters')
    end
    task = current_user.tasks.create({ name: name, due_date: due_date })
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

end
