# Generate completions in memory when the command supports Bash completion.

if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion bash)
fi
if command -v helm >/dev/null 2>&1; then
  source <(helm completion bash)
fi
if command -v flux >/dev/null 2>&1; then
  source <(flux completion bash)
fi
if command -v kustomize >/dev/null 2>&1; then
  source <(kustomize completion bash)
fi
if command -v k9s >/dev/null 2>&1; then
  source <(k9s completion bash)
fi
