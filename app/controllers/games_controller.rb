class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  def index
    @games = Game.all.where("user_id = ? OR opponent = ?", current_user.id, current_user.id)
  end

  def rank
    @games = Game.all
    my_score=[]
    @user_score=[]
    User.all.each do |user|
      mine_game=Game.all.where("user_id = ?", user.id)
      other_game=Game.all.where("opponent = ?", user.id)
      total_games_played= mine_game.size + other_game.size
      if (mine_game.size >0)
        mine_game.each do |game|
          my_score << game.my_score
        end
      end
      if (other_game.size >0)
        other_game.each do |game|
          my_score << game.opponent_score
        end
      end
      @mine_total = my_score.inject(:+)
 @user_score << {user.email => @mine_total}
      @user_score =@user_score.sort_by {|k, v| v}.reverse
     end
  end

  # GET /games/1
  def show
    @date = @game.date
  end

  # GET /games/new
  def new
    puts "====current_user====#{current_user.inspect}"
    puts "====current_user====#{current_user}"
    @opponents = User.all.where("id != ?", current_user.id)
    puts "====other_user===#{@opponents.inspect }"
    @game = Game.new
    @game.user_id=current_user.id
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    @game.user_id=current_user.id
    if @game.save
      puts "---in save"
      redirect_to @game, notice: 'Game was successfully created.'
    else
      puts "--in else"
      render :new
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def game_params
    params.require(:game).permit(:date, :opponent, :my_score, :opponent_score, :user_id)
  end
end

=begin
  def rank
    @games = Game.all
    self_registered_total=0
    user_array=[]
    my_score_count = []
    user_self_count = []
    user_as_opponent=[]

    @user=User.all
    @user.each do |user|
      @user_self_registered= user.games.to_a
      self_registered_total=0
      if @user_self_registered.size >0

        @user_self_registered.each do |s|
          my_score_count << s.my_score
        end
        self_registered_total =my_score_count.inject(:+)
        user_self_count << {user.email => self_registered_total}
      end

      total_score_as_opponent=0
      @games.each do |game|
        if game.opponent==user.id
          user_as_opponent << game.opponent_score
          total_score_as_opponent = user_as_opponent.inject(:+)

        end
      end
      user_array << {user.email => total_score_as_opponent}
    end
    final_score =[]
    z=[]

    puts "===user_array======#{user_array}="
    puts "===========user_self_count===#{user_self_count}"
    user_array.each do |user_score|
      puts "====user score#{user_score.keys }"
      user_self_count.each do |s|
        z=  user_score.merge(s){ |k, user_score, s| user_score + s }

        score=[]
        if s.keys == user_score.keys
          puts "===same key========"
          score = s.values + user_score.values

#          final_score= score.inject(:+)
        else
          puts "======not same keys===#{s}"

        end

        final_score<< score.inject(:+)

        puts "======final_score===#{final_score }"
      end
      puts"===========z=======#{z}"

    end
  end
=end
