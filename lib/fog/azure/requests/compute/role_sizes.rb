module Fog
  module Compute
    class Azure
      class Real
        def role_sizes
          @base_svc.list_role_sizes
        end
      end

      class Mock
        def role_sizes
          role_sizes = ["A10", "A11", "A5", "A6", "A7", "A8", "A9", "Basic_A0", "Basic_A1", "Basic_A2", "Basic_A3", "Basic_A4", "ExtraLarge", "ExtraSmall", "Large", "Medium", "Small", "Standard_D1", "Standard_D11", "Standard_D12", "Standard_D13", "Standard_D14", "Standard_D2", "Standard_D3", "Standard_D4", "Standard_DS1", "Standard_DS11", "Standard_DS12", "Standard_DS13", "Standard_DS14", "Standard_DS2", "Standard_DS3", "Standard_DS4", "Standard_G1", "Standard_G2", "Standard_G3", "Standard_G4", "Standard_G5"]
          role_sizes
        end
      end
    end
  end
end
