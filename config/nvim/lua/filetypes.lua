vim.filetype.add({
  filename = {
    ["Jenkinsfile"] = "groovy",
  },
  pattern = {
    [".*/%.vscode/.*%.json"] = "jsonc",
    [".*playbooks/.*%.yml"] = "ansible.yaml",
    [".*%.yml%.liquid"] = "yaml",
  },
})
