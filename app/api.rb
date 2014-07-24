require 'grape'
require 'ruby-hl7'
require 'pry'

class HL7Example < Grape::API
  content_type :txt, 'text/plain'

  get '/' do
    msg = HL7::Message.new
    msh = HL7::Message::Segment::MSH.new
      msh.sending_app = 'hl7example'
      msh.sending_facility = 'a computer'
      msh.recv_app = 'anonymous'
      msh.recv_facility = 'the internet'
      msh.processing_id = '1234'
      msh.security = '\o/'
    msg << msh

    pid = HL7::Message::Segment::PID.new
      pid.citizenship = 'Chinese'
      pid.species_code = 'Neophocaena asiaeorientalis ssp. asiaeorientalis'
      pid.breed_code = 'DOLP'
    msg << pid

    msg.to_hl7
  end

  post '/' do
    msg = HL7::Message.new(params[:msg])
    msg.inspect
  end
end
