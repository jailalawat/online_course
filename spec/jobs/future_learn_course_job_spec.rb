# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FutureLearnCourseJob, type: :job do
  include ActiveJob::TestHelper
  before(:each) do
    response = [{
      'uuid' => unique_number,
      'image_url' => '',
      'header_image_url' => '',
      'name' => faker_generate_name,
      'introduction' => faker_generate_paragraph,
      'description' => faker_generate_paragraph,
      'categories' => {
        '0' => faker_generate_name,
        '1' => faker_generate_name
      },
      'organisation' => {
        'uuid' => unique_number,
        'name' => faker_generate_name,
        'logo_url' => ''
      }
    }]
    stub_request(:get, 'https://www.futurelearn.com/feeds/courses').to_return(status: 200, body: response.to_json)
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
