# Bluesky Embed Quarto Extension

This Quarto extension provides a shortcode for embedding Bluesky feeds in your Quarto documents.

## Installation

To install this extension in your Quarto project, run:

```bash
quarto add smach/bsky-embed
```

## Usage

Use the `bsky-embed` shortcode in your `.qmd` documents:

### Basic Example

```markdown
{{< bsky-embed username="vincentwill.com" >}}
```

### With Options

```markdown
{{< bsky-embed username="vincentwill.com" mode="dark" limit="5" >}}
```

### Search Posts

```markdown
{{< bsky-embed search="#BuildInPublic" limit="5" >}}
```

### Custom Feed

```markdown
{{< bsky-embed feed="at://did:plc:jcoy7v3a2t4rcfdh6i4kza25/app.bsky.feed.generator/astro" limit="5" >}}
```

## Available Options

All options from the web component are supported:

### Required (at least one)

- `username`: User handle (e.g., "vincentwill.com")
- `feed`: Feed ID (e.g., "at://...")
- `search`: Search term (e.g., "#BuildInPublic")

### Optional

- `limit`: Number of posts to display (default: 10)
- `mode`: Set to "dark" for dark mode
- `link-target`: Link target behavior ("_self", "_blank", "_parent", "_top")
- `link-image`: Make images clickable links ("true" or "false")
- `load-more`: Enable load more button ("true" or "false")
- `disable-styles`: Disable default styles ("true" or "false")
- `disable-images`: Hide images ("true" or "false")
- `disable-videos`: Hide videos ("true" or "false")
- `disable-autoplay`: Disable video autoplay ("true" or "false")
- `custom-styles`: Custom CSS styles as a string
- `custom-styles-file`: URL to custom CSS file
- `date-format`: JSON string for date formatting

## Example

See the `example.qmd` file in the repository root for a complete example.

## About

This extension uses the [bsky-embed](https://github.com/Vincenius/bsky-embed) web component to embed Bluesky feeds. The web component is loaded automatically from the jsDelivr CDN.
