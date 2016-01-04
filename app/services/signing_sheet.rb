require "prawn"
require "prawn/table"

class SigningSheet < Prawn::Document
  def initialize(batch)
    super({})
    @batch = batch
    draw_signing_sheet
  end

  private

  def draw_header
    float do
      image "#{Rails.root.join("app/assets/images/favicon.png")}", height: 40, position: :right
    end

    font_size(14) do
      text "Feuille d'émargement"
      move_down 10
    end

    # TODO: Move this to DB
    formatted_text [ { text: "#{@batch.city.company_name ? @batch.city.company_name : 'Le Wagon'}", styles: [ :bold ] }, { text: " - #{@batch.city.company_nature ? @batch.city.company_nature : 'Société par Actions Simplifiée au capital de 1000 euros'}" } ]
    text "#{@batch.city.company_hq ? @batch.city.company_hq : 'Siège social : 24 rue Louis Blanc 75010 Paris - 794 949 917 RCS Paris'}"
    text "#{@batch.city.company_purpose_and_registration ? @batch.city.purpose_and_registration : 'Organisme de formation enregistré auprès de la DIRECCTE IDF sous le n° 11 75 50770 75'}"
  end

  def draw_context
    # TODO: Move this to DB
    text "Formation FullStack (Batch ##{@batch.slug}) " \
      + " se déroulant du #{I18n.l @batch.starts_at, locale: :fr} au #{I18n.l(@batch.starts_at + 9.weeks - 3.days, locale: :fr)}" \
      + " au #{@batch.city.training_address ? @batch.city.training_address : '16 Villa Gaudelet 75011 Paris'}"
  end

  def draw_students_table
    data = [ [ "Nom", { content: "9h - 13h", align: :center }, { content: "15h - 19h", align: :center} ] * 2 ]
    @batch.users.sort_by {|u| u.last_name.downcase}.each_slice(2) do |slice|
      data << [ slice.first.name, "", "", slice.length > 1 ? slice.last.name : "-", "", "" ]
    end

    table = make_table(data, column_widths: [ 125, 70, 70, 125, 70, 70 ]) do
      cells.style padding_top: 7, padding_bottom: 7
      row(0).font_style = :bold
    end
    table.draw
  end

  def draw_footer
    bounding_box([0, cursor - 20], width: 130, height: 110, padding: 10) do
      transparent(0.5) { stroke_bounds }
      move_down 5
      text "Date", align: :center
    end

    bounding_box([150, cursor + 110], width: 170, height: 110, padding: 10) do
      transparent(0.5) { stroke_bounds }
      move_down 5
      text "Nom & Signature Formateur", align: :center
    end

    bounding_box([340, cursor + 110], width: 190, height: 110, padding: 10) do
      transparent(0.5) { stroke_bounds }
      move_down 5
      text "Cachet de l'organisme de formation", align: :center
    end
  end

  def draw_signing_sheet
    font "Helvetica"
    font_size(10)

    draw_header
    move_down 20

    draw_context
    move_down 10

    draw_students_table

    draw_footer
  end
end
