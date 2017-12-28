module Support
  module Fixtures
    # Load fixture file
    def fixture(file)
      File.read(
        File.join(
          File.expand_path('../../fixtures', __FILE__),
          file
        )
      )
    end
  end
end
