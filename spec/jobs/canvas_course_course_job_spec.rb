# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CanvasCourseCourseJob, type: :job do
  include ActiveJob::TestHelper
  before(:each) do
    response = {
      products: [{
        'id' => unique_number,
        'image' => '',
        'logo' => {
          'url' => '',
          'account_id' => unique_number,
          'label' => faker_generate_name
        },
        'priceWithCurrency' => '$0',
        'teaser' => faker_generate_paragraph,
        'title' => faker_generate_name,
        'type' => faker_generate_name
      }]
    }
    stub_request(:get, 'https://www.canvas.net/products.json').to_return(status: 200, body: response.to_json)
  end

  it 'queues the job' do
    expect { described_class.perform_later }
      .to change(enqueued_jobs, :size).by(1)
  end

  it 'executes perform' do
    perform_enqueued_jobs { described_class.perform_later }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
