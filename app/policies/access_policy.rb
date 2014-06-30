class AccessPolicy
  attr_reader :current_user, :model
  
  # susikuriu toki faila ir tada is bet kurio kontrolerio kvieciu 'authorize Access', tada pagal poreikius padarau leidimus, kas kur gali patekti.
  
  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end
  
  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    false
  end

  def update?
    false
  end

  def edit?
    false
  end

  def destroy?
    false
  end
  
  class Scope < Struct.new(:current_user, :model)
    def resolve
      if current_user.admin?
        User.all
      else
        User.where(email: current_user.email)
      end
    end
  end
  
end