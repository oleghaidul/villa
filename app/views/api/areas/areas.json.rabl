node do |t|
  child t.children do |area|
    attributes :id, :name, :depth, :top, :left_tail

    node(:rental) { |area| area.rental? }
    node(:sale) { |area| area.sale? }
    node(:left) { |area| area.read_attribute(:left) }
    node(:parent_id) { |area| area.parent.id }

    extends "api/areas/areas"
  end
end
