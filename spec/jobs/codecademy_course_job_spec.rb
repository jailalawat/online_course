# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CodecademyCourseJob, type: :job do
  include ActiveJob::TestHelper
  before(:each) do
    response = {
      entities: {
        paths: {
          byId: {
            '5cacbe7b3709024753e7c3ff' => {
              'id' => unique_number,
              'organization_id' => faker_generate_name,
              'title' => faker_generate_name,
              'description' => faker_generate_paragraph,
              'short_description' => faker_generate_paragraph,
              'splash_image': {
                'url' => ''
              },
              'content_item_type_counts' => {
                'informational' => unique_number,
                'project' => unique_number,
                'lesson' => unique_number,
                'article' => unique_number,
                'quiz' => unique_number
              }
            }
          }
        }
      }
    }
    stub_request(:get, 'https://www.codecademy.com/catalog/all.json').to_return(status: 200, body: response.to_json)
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
