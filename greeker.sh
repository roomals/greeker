#!/bin/bash

# Function to print usage information
print_usage() {
    echo "Usage: $0 input_file [output_file] [--pdf]"
    echo "Example: $0 input.txt output.md"
    echo "Optional: Use '--pdf' flag to also convert the output to a PDF file."
    echo "Example: $0 input.txt output.md --pdf"
}

# Check if input file is provided
if [[ $# -lt 1 || "$1" == "--help" || "$1" == "-h" ]]; then
    print_usage
    exit 0
fi

input_file="$1"
output_file="${2:-${input_file%.*}_converted.md}"
convert_to_pdf_flag=false

# Check if the --pdf flag is set
if [[ "$#" -eq 3 && "$3" == "--pdf" ]]; then
    convert_to_pdf_flag=true
elif [[ "$#" -gt 3 ]]; then
    print_usage
    exit 1
fi

# Check if input file exists and is readable
if [ ! -r "$input_file" ]; then
    echo "Error: Input file '$input_file' not found or not readable."
    exit 1
fi

# Define a function to perform replacements
replace_greek_and_cyrillic_letters() {
    sed -e 's/Α/\&Alpha;/g' \
        -e 's/α/\&alpha;/g' \
        -e 's/Β/\&Beta;/g' \
        -e 's/β/\&beta;/g' \
        -e 's/Γ/\&Gamma;/g' \
        -e 's/γ/\&gamma;/g' \
        -e 's/Δ/\&Delta;/g' \
        -e 's/δ/\&delta;/g' \
        -e 's/Ε/\&Epsilon;/g' \
        -e 's/ε/\&epsilon;/g' \
        -e 's/Ζ/\&Zeta;/g' \
        -e 's/ζ/\&zeta;/g' \
        -e 's/Η/\&Eta;/g' \
        -e 's/η/\&eta;/g' \
        -e 's/Θ/\&Theta;/g' \
        -e 's/θ/\&theta;/g' \
        -e 's/Ι/\&Iota;/g' \
        -e 's/ι/\&iota;/g' \
        -e 's/Κ/\&Kappa;/g' \
        -e 's/κ/\&kappa;/g' \
        -e 's/Λ/\&Lambda;/g' \
        -e 's/λ/\&lambda;/g' \
        -e 's/Μ/\&Mu;/g' \
        -e 's/μ/\&mu;/g' \
        -e 's/Ν/\&Nu;/g' \
        -e 's/ν/\&nu;/g' \
        -e 's/Ξ/\&Xi;/g' \
        -e 's/ξ/\&xi;/g' \
        -e 's/Ο/\&Omicron;/g' \
        -e 's/ο/\&omicron;/g' \
        -e 's/Π/\&Pi;/g' \
        -e 's/π/\&pi;/g' \
        -e 's/Ρ/\&Rho;/g' \
        -e 's/ρ/\&rho;/g' \
        -e 's/Σ/\&Sigma;/g' \
        -e 's/σ/\&sigma;/g' \
        -e 's/ς/\&sigma;/g' \
        -e 's/Τ/\&Tau;/g' \
        -e 's/τ/\&tau;/g' \
        -e 's/Υ/\&Upsilon;/g' \
        -e 's/υ/\&upsilon;/g' \
        -e 's/Φ/\&Phi;/g' \
        -e 's/φ/\&phi;/g' \
        -e 's/Χ/\&Chi;/g' \
        -e 's/χ/\&chi;/g' \
        -e 's/Ψ/\&Psi;/g' \
        -e 's/ψ/\&psi;/g' \
        -e 's/Ω/\&Omega;/g' \
        -e 's/ω/\&omega;/g' \
        -e 's/А/\&Acy;/g' \
        -e 's/Б/\&Bcy;/g' \
        -e 's/В/\&Vcy;/g' \
        -e 's/Г/\&Gcy;/g' \
        -e 's/Д/\&Dcy;/g' \
        -e 's/Е/\&IEcy;/g' \
        -e 's/Ё/\&IOcy;/g' \
        -e 's/Ж/\&ZHcy;/g' \
        -e 's/З/\&Zcy;/g' \
        -e 's/И/\&Icy;/g' \
        -e 's/Й/\&Jcy;/g' \
        -e 's/К/\&Kcy;/g' \
        -e 's/Л/\&Lcy;/g' \
        -e 's/М/\&Mcy;/g' \
        -e 's/Н/\&Ncy;/g' \
        -e 's/О/\&Ocy;/g' \
        -e 's/П/\&Pcy;/g' \
        -e 's/Р/\&Rcy;/g' \
        -e 's/С/\&Scy;/g' \
        -e 's/Т/\&Tcy;/g' \
        -e 's/У/\&Ucy;/g' \
        -e 's/Ф/\&Fcy;/g' \
        -e 's/Х/\&KHcy;/g' \
        -e 's/Ц/\&TScy;/g' \
        -e 's/Ч/\&CHcy;/g' \
        -e 's/Ш/\&SHcy;/g' \
        -e 's/Щ/\&SHCHcy;/g' \
        -e 's/Ъ/\&HARDcy;/g' \
        -e 's/Ы/\&Ycy;/g' \
        -e 's/Ь/\&SOFTcy;/g' \
        -e 's/Э/\&Ecy;/g' \
        -e 's/Ю/\&YUcy;/g' \
        -e 's/Я/\&YAcy;/g' \
        -e 's/а/\&acy;/g' \
        -e 's/б/\&bcy;/g' \
        -e 's/в/\&vcy;/g' \
        -e 's/г/\&gcy;/g' \
        -e 's/д/\&dcy;/g' \
        -e 's/е/\&iecy;/g' \
        -e 's/ё/\&iocy;/g' \
        -e 's/ж/\&zhcy;/g' \
        -e 's/з/\&zcy;/g' \
        -e 's/и/\&icy;/g' \
        -e 's/й/\&jcy;/g' \
        -e 's/к/\&kcy;/g' \
        -e 's/л/\&lcy;/g' \
        -e 's/м/\&mcy;/g' \
        -e 's/н/\&ncy;/g' \
        -e 's/о/\&ocy;/g' \
        -e 's/п/\&pcy;/g' \
        -e 's/р/\&rcy;/g' \
        -e 's/с/\&scy;/g' \
        -e 's/т/\&tcy;/g' \
        -e 's/у/\&ucy;/g' \
        -e 's/ф/\&fcy;/g' \
        -e 's/х/\&khcy;/g' \
        -e 's/ц/\&tscy;/g' \
        -e 's/ч/\&chcy;/g' \
        -e 's/ш/\&shcy;/g' \
        -e 's/щ/\&shchcy;/g' \
        -e 's/ъ/\&hardcy;/g' \
        -e 's/ы/\&ycy;/g' \
        -e 's/ь/\&softcy;/g' \
        -e 's/э/\&ecy;/g' \
        -e 's/ю/\&yucy;/g' \
        -e 's/я/\&yacy;/g'
}

# Function to convert Markdown to PDF
convert_to_pdf() {
    local input_file="$1"
    local output_file="${input_file%.md}.pdf"
    if command -v pandoc >/dev/null 2>&1; then
        pandoc "$input_file" -o "$output_file" --pdf-engine=xelatex -V mainfont="FreeSerif"
        echo "PDF conversion complete. Output saved to '$output_file'"
    else
        echo "Pandoc is not installed. Please install pandoc to use the PDF conversion feature."
    fi
}

# Perform replacements and save output to the specified or default file
replace_greek_and_cyrillic_letters < "$input_file" > "$output_file"

echo "Conversion complete. Output saved to '$output_file'"

# Convert to PDF if the flag is set
if [ "$convert_to_pdf_flag" = true ]; then
    convert_to_pdf "$output_file"
fi