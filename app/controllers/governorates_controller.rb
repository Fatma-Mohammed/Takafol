class GovernoratesController < InheritedResources::Base

  private

    def governorate_params
      params.require(:governorate).permit()
    end

end
