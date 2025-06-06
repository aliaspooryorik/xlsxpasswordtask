# Add XLSX Password Tool

This is a CommandBox task that adds password protection to all XLSX files in a specified directory recursively.

## Installation

- Clone this repo
- Change into the directory
- Install commandbox (for example `brew install commandbox`)
- Install dependancies (for example `box install`)

## Usage

### Options

- **password**: The password to protect the files with (required)
- **directory**: The directory containing XLSX files (required)

### Examples

```bash
# prompted for parameters
box task run

# pass in the parameters
box task run :password="yourpassword" :directory="./myExcelFiles/"
```

## Requirements

- [CommandBox 6](https://commandbox.ortusbooks.com/)

## Notes

- It **does not backup** the file first
- This tool uses the [spreadsheet-cfml](https://github.com/cfsimplicity/spreadsheet-cfml) module
- The "agile" algorithm is used for best compatibility with modern versions of Microsoft Excel

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
