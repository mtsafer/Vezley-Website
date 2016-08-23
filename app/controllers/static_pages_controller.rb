class StaticPagesController < ApplicationController
  def home
    @infoblocks = InfoBlock.where.not(name: "manifesto")
  end

  def manifesto
    @infoblock = InfoBlock.find_by_name("manifesto")
  end

  def contact_post
  end

  def thanks
  end

  def cancel
  end

end
