-- bsky-embed.lua
-- Quarto shortcode for embedding Bluesky feeds

-- Default values
local DEFAULT_LIMIT = "10"
local DEFAULT_LINK_TARGET = "_self"
local DEFAULT_BOOLEAN = "false"

-- HTML escape function to prevent XSS
local function escapeHtml(str)
  if not str then return "" end
  str = str:gsub("&", "&amp;")
  str = str:gsub("<", "&lt;")
  str = str:gsub(">", "&gt;")
  str = str:gsub('"', "&quot;")
  str = str:gsub("'", "&#39;")
  return str
end

-- Helper function to add attribute only if value is not default
local function addAttributeIfNotDefault(attrs, name, value, default)
  if value ~= "" and value ~= default then
    table.insert(attrs, string.format('%s="%s"', name, escapeHtml(value)))
  end
end

local function ensureHtmlDeps()
  quarto.doc.add_html_dependency({
    name = 'bsky-embed',
    version = '0.2.7',
    scripts = {
      { 
        path = "",
        attribs = {
          src = "https://cdn.jsdelivr.net/npm/bsky-embed/dist/bsky-embed.es.js",
          type = "module",
          async = ""
        },
        afterBody = true
      }
    }
  })
end

return {
  ['bsky-embed'] = function(args, kwargs, meta)
    -- Add the script dependency to the document
    ensureHtmlDeps()
    
    -- Get parameters from kwargs with defaults
    local username = pandoc.utils.stringify(kwargs["username"] or "")
    local feed = pandoc.utils.stringify(kwargs["feed"] or "")
    local search = pandoc.utils.stringify(kwargs["search"] or "")
    local limit = pandoc.utils.stringify(kwargs["limit"] or DEFAULT_LIMIT)
    local mode = pandoc.utils.stringify(kwargs["mode"] or "")
    local linkTarget = pandoc.utils.stringify(kwargs["link-target"] or DEFAULT_LINK_TARGET)
    local linkImage = pandoc.utils.stringify(kwargs["link-image"] or DEFAULT_BOOLEAN)
    local loadMore = pandoc.utils.stringify(kwargs["load-more"] or DEFAULT_BOOLEAN)
    local disableStyles = pandoc.utils.stringify(kwargs["disable-styles"] or DEFAULT_BOOLEAN)
    local customStyles = pandoc.utils.stringify(kwargs["custom-styles"] or "")
    local customStylesFile = pandoc.utils.stringify(kwargs["custom-styles-file"] or "")
    local dateFormat = pandoc.utils.stringify(kwargs["date-format"] or "")
    local disableImages = pandoc.utils.stringify(kwargs["disable-images"] or DEFAULT_BOOLEAN)
    local disableVideos = pandoc.utils.stringify(kwargs["disable-videos"] or DEFAULT_BOOLEAN)
    local disableAutoplay = pandoc.utils.stringify(kwargs["disable-autoplay"] or DEFAULT_BOOLEAN)
    
    -- Build the HTML attributes
    local attrs = {}
    
    -- Required attributes (at least one must be present)
    addAttributeIfNotDefault(attrs, "username", username, nil)
    addAttributeIfNotDefault(attrs, "feed", feed, nil)
    addAttributeIfNotDefault(attrs, "search", search, nil)
    
    -- Optional attributes with defaults
    addAttributeIfNotDefault(attrs, "limit", limit, DEFAULT_LIMIT)
    addAttributeIfNotDefault(attrs, "mode", mode, nil)
    addAttributeIfNotDefault(attrs, "link-target", linkTarget, DEFAULT_LINK_TARGET)
    addAttributeIfNotDefault(attrs, "link-image", linkImage, DEFAULT_BOOLEAN)
    addAttributeIfNotDefault(attrs, "load-more", loadMore, DEFAULT_BOOLEAN)
    addAttributeIfNotDefault(attrs, "disable-styles", disableStyles, DEFAULT_BOOLEAN)
    addAttributeIfNotDefault(attrs, "custom-styles", customStyles, nil)
    addAttributeIfNotDefault(attrs, "custom-styles-file", customStylesFile, nil)
    addAttributeIfNotDefault(attrs, "date-format", dateFormat, nil)
    addAttributeIfNotDefault(attrs, "disable-images", disableImages, DEFAULT_BOOLEAN)
    addAttributeIfNotDefault(attrs, "disable-videos", disableVideos, DEFAULT_BOOLEAN)
    addAttributeIfNotDefault(attrs, "disable-autoplay", disableAutoplay, DEFAULT_BOOLEAN)
    
    -- Create the HTML element
    local attrsStr = table.concat(attrs, ' ')
    local html
    if attrsStr ~= "" then
      html = string.format('<bsky-embed %s></bsky-embed>', attrsStr)
    else
      html = '<bsky-embed></bsky-embed>'
    end
    
    -- Return as raw HTML
    return pandoc.RawBlock('html', html)
  end
}
