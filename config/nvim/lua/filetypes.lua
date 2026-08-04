vim.filetype.add({
  filename = {
    ["Jenkinsfile"] = "groovy",
  },
  pattern = {
    [".*/%.vscode/settings%.json"] = "jsonc",
    [".*playbooks/.*%.yml"] = "ansible.yaml",
    [".*%.yml%.liquid"] = "yaml",
  },
})
