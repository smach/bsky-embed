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
    
    if username ~= "" then
      table.insert(attrs, string.format('username="%s"', escapeHtml(username)))
    end
    
    if feed ~= "" then
      table.insert(attrs, string.format('feed="%s"', escapeHtml(feed)))
    end
    
    if search ~= "" then
      table.insert(attrs, string.format('search="%s"', escapeHtml(search)))
    end
    
    if limit ~= "" and limit ~= DEFAULT_LIMIT then
      table.insert(attrs, string.format('limit="%s"', escapeHtml(limit)))
    end
    
    if mode ~= "" then
      table.insert(attrs, string.format('mode="%s"', escapeHtml(mode)))
    end
    
    if linkTarget ~= "" and linkTarget ~= DEFAULT_LINK_TARGET then
      table.insert(attrs, string.format('link-target="%s"', escapeHtml(linkTarget)))
    end
    
    if linkImage ~= "" and linkImage ~= DEFAULT_BOOLEAN then
      table.insert(attrs, string.format('link-image="%s"', escapeHtml(linkImage)))
    end
    
    if loadMore ~= "" and loadMore ~= DEFAULT_BOOLEAN then
      table.insert(attrs, string.format('load-more="%s"', escapeHtml(loadMore)))
    end
    
    if disableStyles ~= "" and disableStyles ~= DEFAULT_BOOLEAN then
      table.insert(attrs, string.format('disable-styles="%s"', escapeHtml(disableStyles)))
    end
    
    if customStyles ~= "" then
      table.insert(attrs, string.format('custom-styles="%s"', escapeHtml(customStyles)))
    end
    
    if customStylesFile ~= "" then
      table.insert(attrs, string.format('custom-styles-file="%s"', escapeHtml(customStylesFile)))
    end
    
    if dateFormat ~= "" then
      table.insert(attrs, string.format('date-format="%s"', escapeHtml(dateFormat)))
    end
    
    if disableImages ~= "" and disableImages ~= DEFAULT_BOOLEAN then
      table.insert(attrs, string.format('disable-images="%s"', escapeHtml(disableImages)))
    end
    
    if disableVideos ~= "" and disableVideos ~= DEFAULT_BOOLEAN then
      table.insert(attrs, string.format('disable-videos="%s"', escapeHtml(disableVideos)))
    end
    
    if disableAutoplay ~= "" and disableAutoplay ~= DEFAULT_BOOLEAN then
      table.insert(attrs, string.format('disable-autoplay="%s"', escapeHtml(disableAutoplay)))
    end
    
    -- Create the HTML element
    local html = string.format('<bsky-embed %s></bsky-embed>', table.concat(attrs, ' '))
    
    -- Return as raw HTML
    return pandoc.RawBlock('html', html)
  end
}
