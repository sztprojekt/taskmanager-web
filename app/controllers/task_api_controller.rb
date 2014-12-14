class TaskApiController < ApiController

  def all
    succeed_with_data({ tasks: @user.tasks })
  end

  def one
    begin
      id = params.require :id
    rescue KeyError
      return die 'Missing task id'
    end
    task = Task.find_by(id: id, user_id: @user.id)
    return die 'Task not found' if task.nil?
    succeed_with_data({task: task})
  end

  def update_status
    begin
      id = params.require :id
      status = params.require :status
    rescue KeyError
      return die 'Missing task id or status'
    end
    task = Task.find_by(id: id, user_id: @user.id)
    return die 'Task not found' if task.nil?
    status = (status.to_i == 1)
    completed_at = status ? Time.now : nil
    Task.update(task.id, status: status, completed_at: completed_at)
    success 'Task updated successully'
  end


end
