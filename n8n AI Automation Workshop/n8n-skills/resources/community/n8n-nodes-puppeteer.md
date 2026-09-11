# n8n-nodes-puppeteer

## Basic Information

- Package: `n8n-nodes-puppeteer`
- Category: 🕷️ Web Scraping & Browser Automation
- Version: 1.5.0
- Maintainer: drudge
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-puppeteer)
- Repository: [View Source](https://github.com/drudge/n8n-nodes-puppeteer)

## Description

n8n node for browser automation using Puppeteer

## Installation

```
n8n-nodes-puppeteer
```

## Nodes (1)

### Puppeteer

- Node Type: `n8n-nodes-puppeteer.puppeteer`
- Version: 1

Automate browser interactions using Puppeteer

#### Available Operations

- **Get Page Content** (`getPageContent`)
  Gets the full HTML contents of the page
- **Get PDF** (`getPDF`)
  Captures all or part of the page as a PDF
- **Get Screenshot** (`getScreenshot`)
  Captures all or part of the page as an image
- **Run Custom Script** (`runCustomScript`)
  Runs custom code to perform specific actions on the page

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `url` | string | Yes | `""` |
| `scriptCode` | string | Yes | `"// Navigate to an IP lookup service\nawait $page.goto('https://httpbin.org/ip');\n\n// Extract the IP address from the page content\nconst ipData = await $page.evaluate(() => {\n    const response = document.body.innerText;\n    const parsed = JSON.parse(response);\n    return parsed.origin;  // Extract the 'origin' field, which typically contains the IP address\n});\n\nconsole.log(\"Hello, world!\");\n\nconsole.log(\"IP Address\", ipData);\n\n// Return the result in the required format\nreturn [{ ip: ipData, ...$json }];"` |
| `dataPropertyName` | string | Yes | `"data"` |
| `scale` | number | Yes | `1` |
| `preferCSSPageSize` | boolean | Yes | `true` |
| `landscape` | boolean | Yes | `true` |
| `displayHeaderFooter` | boolean | Yes | `false` |
| `omitBackground` | boolean | Yes | `false` |
| `printBackground` | boolean | Yes | `false` |
| `fullPage` | boolean | Yes | `false` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Puppeteer",
  "type": "n8n-nodes-puppeteer.puppeteer",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "url": "",
    "scriptCode": "// Navigate to an IP lookup service\nawait $page.goto('https://httpbin.org/ip');\n\n// Extract the IP address from the page content\nconst ipData = await $page.evaluate(() => {\n    const response = document.body.innerText;\n    const parsed = JSON.parse(response);\n    return parsed.origin;  // Extract the 'origin' field, which typically contains the IP address\n});\n\nconsole.log(\"Hello, world!\");\n\nconsole.log(\"IP Address\", ipData);\n\n// Return the result in the required format\nreturn [{ ip: ipData, ...$json }];",
    "dataPropertyName": "data",
    "scale": 1,
    "preferCSSPageSize": true,
    "operation": "getPageContent"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
