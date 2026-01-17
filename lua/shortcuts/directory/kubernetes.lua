local directory_utils = require('shortcuts.utils.directory')
local M = {}

function M.is_kubernetes_directory()
    local k8s_indicators = {
        "k8s/",
        "kubernetes/",
        "kustomize/",
        "manifests/",
        "helm/",
    }

    return directory_utils.is_directory_with_indicators(k8s_indicators)
end

return M
