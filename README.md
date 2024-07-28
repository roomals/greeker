# Greeker

Greeker is a script designed for biblical scholars that converts Greek and Old Slavonic (all Slavonic languages) text into Markdown with proper HTML entities for special characters. The script also has an optional feature to convert the Markdown file into a PDF.

## Features

- Converts Greek and Cyrillic letters to their respective HTML entities.
- Option to convert the output Markdown file to a PDF.
- Easy to use with a simple command-line interface.

## Installation

Ensure you have the dependencies installed on your system. On Ubuntu- or Debian-based systems, you can install these with:

```bash
sudo apt-get install sed pandoc texlive-xetex fonts-freefont-ttf -y
```

### Dependencies
- **sed**: Stream editor for filtering and transforming text.
- **pandoc**: Universal document converter.
- **texlive-xetex**: A TeX Live distribution with support for XeLaTeX.
- **fonts-freefont-ttf**: FreeSerif font that includes extensive Unicode coverage.

## Usage

### Make the Greeker Script Executable

```bash
chmod +x greeker.sh
```

### Convert a text file to Markdown:

```bash
bash greeker.sh input_file [output_file]
bash greeker.sh input.txt output.md
```

### Convert a text file to Markdown and then to PDF:

```bash
bash greeker.sh input.txt output.md --pdf
```

## Example

### Input Text (input.txt)
```
Въ нача́ле бѣ́ слово, и сло́во бѣ́ къ Бо́гу, и бо́гъ бѣ́ сло́во.
Alpha: Α, alpha: α
Beta: Β, beta: β
```

### Output Markdown (output.md)
```markdown
---
title: "Example Text"
author: "Your Name"
date: "2024-07-27"
---

Въ нача́ле бѣ́ слово, и сло́во бѣ́ къ Бо́гу, и бо́гъ бѣ́ сло́во.
Alpha: &Alpha;, alpha: &alpha;
Beta: &Beta;, beta: &beta;
```

### Convert to PDF

To convert the Markdown file to a PDF, use the `--pdf` flag:

```bash
bash greeker.sh input.txt output.md --pdf
```

This will generate a `output.pdf` file with the properly formatted text.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

### Additional Files

- `example_input.txt`: Sample input file with Greek and Old Slavonic text.
- `example_output.md`: Example output file after conversion.
- `LICENSE`: License file for the project.

By following this README, users should be able to set up and use the Greeker script effectively.
