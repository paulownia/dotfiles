vim.filetype.add({
  filename = {
    ["Jenkinsfile"] = "groovy",
  },
  pattern = {
    [".*playbooks/.*%.yml"] = "ansible.yaml",
    [".*%.yml%.liquid"] = "yaml",
  },
})
