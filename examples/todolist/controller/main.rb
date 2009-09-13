#          Copyright (c) 2006 Michael Fellinger m.fellinger@gmail.com
# All files in this distribution are subject to the terms of the Ruby license.

# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class MainController < Ramaze::Controller
  engine :Slippers
  def index
    @tasks = []
    TodoList.original.each do |title, value|
      if value[:done]
        status = 'done'
        toggle = 'open'
      else
        status = 'not done'
        toggle = 'close'
      end
      @tasks << {:title => title, :status => status, :resource => title, :toggle => toggle}
    end
    @heading = "TodoList"
    #@tasks.sort!
  end

  def create
    if title = request['title']
      title.strip!
      if title.empty?
        failed("Please enter a title")
        redirect '/new'
      end
      TodoList[title] = {:done => false}
      redirect route('/', :title => title)
    end
  end

  def open title
    task_status title, false
  end

  def close title
    task_status title, true
  end

  def delete title
    TodoList.delete title
  end

  helper :aspect
  after(:create, :open, :close, :delete){ redirect_referrer }

  private

  def failed(message)
    flash[:error] = message
  end

  def task_status title, status
    unless task = TodoList[title]
      failed "No such Task: `#{title}'"
      redirect_referer
    end

    task[:done] = status
    TodoList[title] = task
  end
end
