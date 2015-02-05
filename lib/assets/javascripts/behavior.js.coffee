# Find elements in the scope of another element
$.fn.behavior = (value) -> $(@).find("[data-behavior~='#{value}']")
# Find elements anywhere in document
$.behavior = (value) -> $("[data-behavior~='#{value}']")