module TailgatesHelper

  def star_rating_for(tailgate)
    if tailgate.user.star_rating.nil?
      "No ratings"
    else
      tailgate.user.star_rating
    end
  end

  def tailgate_listing_for(tailgate, &block)
    content_tag :div, class: "panel-body tailgate-listing #{'sold-out' if tailgate.sold_out?}" do
      html = ""
      html += content_tag :div, "SOLD OUT", class: "sold-out-label", style: "display: none;" if tailgate.sold_out?
      html += capture(&block)
      html.html_safe
    end
  end

end
