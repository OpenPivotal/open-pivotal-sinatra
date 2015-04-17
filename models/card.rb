require './models/base'

class Card < Base
  attr_reader :id, :name, :estimate, :description

  def created_at
    Time.parse(@created_at).strftime('%d/%m/%Y')
  end

  def estimate
    @estimate || "-"
  end

  def labels
    @labels.map { |label| label["name"] }.join(', ')
  end
end