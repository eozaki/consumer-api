module Api
  class ProductsController < ApplicationController
    def import
      raise NoImportFileError unless params[:import_file].present?

      ProductsImporterService.import(
        JSON(
          params[:import_file].read.force_encoding('UTF-8')
        )
      )

      render json: :ok
    rescue NoImportFileError => e
      render json: e.message, status: :bad_request
    rescue => e
      render json: e.message, status: :internal_server_error
    end
  end
end
