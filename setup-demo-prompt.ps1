# PowerShell script to automate prompt setup for Wiz MCP + Cursor demo

# Create prompts directory if it doesn't exist
if (-not (Test-Path -Path './prompts')) {
    New-Item -ItemType Directory -Path './prompts' | Out-Null
}

# Copy the prompt template to the prompts directory
Copy-Item -Path './iac-code-to-cloud-traceability.md' -Destination './prompts/iac-code-to-cloud-traceability.md' -Force

# Print instructions
Write-Host 'Prompt template copied to ./prompts/iac-code-to-cloud-traceability.md'
Write-Host 'To use in your demo, open the file and use the system prompt as described.'
Write-Host 'You can add more prompt templates to the prompts directory as needed.' 