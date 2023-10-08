class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]

  PEOPLE_PER_PAGE = 20

  # GET /people or /people.json
  def index
    @title = I18n.t("page_title")

    # sorting
    order = params[:order] || 'descending'
    @people = Person.order(Arel.sql("points #{order == 'ascending' ? 'ASC' : 'DESC'}"),
                        Arel.sql("COALESCE(reputation, -1) #{order == 'ascending' ? 'ASC' : 'DESC'}"),
                        Arel.sql("last_name ASC"),
                        Arel.sql("first_name ASC"))
                 .page(params[:page])
                 .per(PEOPLE_PER_PAGE)
    
    # search
    search_query = params[:search]
    if search_query.present?
      @people = @people.where("lower(first_name) LIKE ? OR lower(last_name) LIKE ?", "%#{search_query.downcase}%", "%#{search_query.downcase}%")
    end

    # filter by cantons
    selected_cantons = session[:selected_cantons] || []

    unless selected_cantons.empty? || selected_cantons.include?("All")
      @people = @people.where(canton: selected_cantons)
    end

    # filter by parties
    selected_parties = session[:selected_parties] || []
    unless selected_parties.empty? || selected_parties.include?("All")
      @people = @people.where(party: selected_parties)
    end

    respond_to do |format|
      format.html
      format.js do
        @has_more_people = @people.total_pages > @people.current_page
        render :index
      end
    end

  end

  def load_more
    @people = Person.order(points: order == 'ascending' ? :asc : :desc, last_name: :asc, first_name: :asc).page(params[:page]).per(PEOPLE_PER_PAGE)
    render layout: false
  end

  # GET /people/1 or /people/1.json
  def show
    @title = @person.first_name + " " + @person.last_name + " (" + @person.canton + ")"
    puts "========== Show action called =========="
  end

  # GET /people/new
  def new
    @person = Person.new
    puts "========== New action called =========="
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people or /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to person_url(@person), notice: "Person was successfully created." }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to person_url(@person), notice: "Person was successfully updated." }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url, notice: "Person was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def filter_cantons
    if params[:selected_cantons].include?("All")
      session[:selected_cantons] = []
    else
      session[:selected_cantons] = params[:selected_cantons]
    end
    head :ok
  end
  
  def get_canton_filter
    selected_cantons = session[:selected_cantons] || []
    if selected_cantons.empty?
      selected_cantons = ["All"]
    end
    render json: { selected_cantons: selected_cantons }
  end

  def filter_parties
    if params[:selected_parties].include?("All")
      session[:selected_parties] = []
    else
      session[:selected_parties] = params[:selected_parties]
    end
    head :ok
  end

  def get_party_filter
    selected_parties = session[:selected_parties] || []
    if selected_parties.empty?
      selected_parties = ["All"]
    end
    render json: { selected_parties: selected_parties }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find_by(slug: params[:slug])
    end
    
    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:first_name, :last_name, :party, :group, :office, :canton, :date_of_birth, :points, :image)
    end
end
