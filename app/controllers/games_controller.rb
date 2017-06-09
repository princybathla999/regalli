class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1
  def show
    @date = @game.date
    puts"----date-1---#{@date }"
    puts"----date--2--#{@date.month   }"
    puts"----date--3--#{@date.day    }"
   # puts"----date--2--#{@date["1"] }"
   # puts"----date---3-#{@date }"
  end

  # GET /games/new
  def new
    puts"====current_user====#{current_user.inspect}"
    puts"====current_user====#{current_user}"
    @other_user=  User.all.where("id != ?", current_user.id)
    puts"====other_user===#{@other_user.inspect }"
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
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
      params.require(:game).permit(:date, :opponent, :my_score, :opponent_score)
    end
end
