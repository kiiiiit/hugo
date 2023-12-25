```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

{{ if .Page.Store.Get "hasMermaid" }} <script type="module"> import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.esm.min.mjs'; mermaid.initialize({ startOnLoad: true }); </script> {{ end }}