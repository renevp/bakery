require 'csv'

module FileUtils
  def self.read_csv(csv_file)
    rows = CSV.read csv_file, headers: true, skip_blanks: true, header_converters: :symbol
  end
end
