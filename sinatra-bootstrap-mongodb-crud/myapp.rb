module CORE

  class Task
    include Mongoid::Document

    field :title, type: String
    field :body, type: String
  end

  class Main < Sinatra::Base
    use Rack::Flash

    configure :development do

      enable :sessions, :logging, :dump_errors, :inline_templates
      enable :methodoverride
      set :root, File.dirname(__FILE__)
      logger = Logger.new($stdout)

      Mongoid.configure do |config|
        name = "demoodb"
        host = "localhost"
        config.master = Mongo::Connection.new.db(name)
        #config.logger = Logger.new($stdout, :warn) 
        config.logger = logger
        config.persist_in_safe_mode = false
      end

    end

    before do
      @t = Task.all
      if @t.empty?
        flash[:notice] = "No documents found!"
      end
    end

    get '/' do
      slim :index
    end

    get '/new' do
      t = Task.new
      slim :new
    end

    post '/new' do
      t = Task.new(params[:task])
      if t.save
        redirect '/'
      else
        "Error saving doc"
      end
    end

    get '/show/:id' do |id|
      @t = Task.find(id)
      slim :show
    end

    get '/edit/:id' do |id|
      @t = Task.find(id)
      slim :edit
    end

    put '/update/:id' do
      @t = Task.find(params[:id])
      @t.update_attributes(params[:task])
      slim :show
    end

    delete '/delete/:id' do
      t = Task.find(params[:id])
      if t.delete
        redirect '/'
      else
        flash[:notify] = "Fudeu-se"
      end
    end

  end

end