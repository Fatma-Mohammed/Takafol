class CitiesController < InheritedResources::Base

  private

    def city_params
      params.require(:city).permit()
    end

end
