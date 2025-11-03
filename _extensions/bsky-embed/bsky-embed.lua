-- bsky-embed.lua
-- Quarto shortcode for embedding Bluesky feeds

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
    local limit = pandoc.utils.stringify(kwargs["limit"] or "10")
    local mode = pandoc.utils.stringify(kwargs["mode"] or "")
    local linkTarget = pandoc.utils.stringify(kwargs["link-target"] or "_self")
    local linkImage = pandoc.utils.stringify(kwargs["link-image"] or "false")
    local loadMore = pandoc.utils.stringify(kwargs["load-more"] or "false")
    local disableStyles = pandoc.utils.stringify(kwargs["disable-styles"] or "false")
    local customStyles = pandoc.utils.stringify(kwargs["custom-styles"] or "")
    local customStylesFile = pandoc.utils.stringify(kwargs["custom-styles-file"] or "")
    local dateFormat = pandoc.utils.stringify(kwargs["date-format"] or "")
    local disableImages = pandoc.utils.stringify(kwargs["disable-images"] or "false")
    local disableVideos = pandoc.utils.stringify(kwargs["disable-videos"] or "false")
    local disableAutoplay = pandoc.utils.stringify(kwargs["disable-autoplay"] or "false")
    
    -- Build the HTML attributes
    local attrs = {}
    
    if username ~= "" then
      table.insert(attrs, string.format('username="%s"', username))
    end
    
    if feed ~= "" then
      table.insert(attrs, string.format('feed="%s"', feed))
    end
    
    if search ~= "" then
      table.insert(attrs, string.format('search="%s"', search))
    end
    
    if limit ~= "" and limit ~= "10" then
      table.insert(attrs, string.format('limit="%s"', limit))
    end
    
    if mode ~= "" then
      table.insert(attrs, string.format('mode="%s"', mode))
    end
    
    if linkTarget ~= "" and linkTarget ~= "_self" then
      table.insert(attrs, string.format('link-target="%s"', linkTarget))
    end
    
    if linkImage ~= "" and linkImage ~= "false" then
      table.insert(attrs, string.format('link-image="%s"', linkImage))
    end
    
    if loadMore ~= "" and loadMore ~= "false" then
      table.insert(attrs, string.format('load-more="%s"', loadMore))
    end
    
    if disableStyles ~= "" and disableStyles ~= "false" then
      table.insert(attrs, string.format('disable-styles="%s"', disableStyles))
    end
    
    if customStyles ~= "" then
      -- Escape quotes in custom styles
      local escapedStyles = customStyles:gsub('"', '&quot;')
      table.insert(attrs, string.format('custom-styles="%s"', escapedStyles))
    end
    
    if customStylesFile ~= "" then
      table.insert(attrs, string.format('custom-styles-file="%s"', customStylesFile))
    end
    
    if dateFormat ~= "" then
      -- Escape quotes in date format JSON
      local escapedDateFormat = dateFormat:gsub('"', '&quot;')
      table.insert(attrs, string.format('date-format="%s"', escapedDateFormat))
    end
    
    if disableImages ~= "" and disableImages ~= "false" then
      table.insert(attrs, string.format('disable-images="%s"', disableImages))
    end
    
    if disableVideos ~= "" and disableVideos ~= "false" then
      table.insert(attrs, string.format('disable-videos="%s"', disableVideos))
    end
    
    if disableAutoplay ~= "" and disableAutoplay ~= "false" then
      table.insert(attrs, string.format('disable-autoplay="%s"', disableAutoplay))
    end
    
    -- Create the HTML element
    local html = string.format('<bsky-embed %s></bsky-embed>', table.concat(attrs, ' '))
    
    -- Return as raw HTML
    return pandoc.RawBlock('html', html)
  end
}
