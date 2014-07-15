require 'grape'
require 'ruby-hl7'
require 'pry'

class HL7Example < Grape::API
  content_type :txt, 'text/plain'

  get '/' do
    # create a message
    msg = HL7::Message.new
    # create a MSH segment for our new message
    msh = HL7::Message::Segment::MSH.new
    msh.recv_app = 'ruby hl7'
    msh.recv_facility = 'my office'
    msh.processing_id = '1337'
    # add the MSH segment to the message
    msg << msh

    # msg.to_s # readable version of the message
    msg.to_hl7 # hl7 version of the message (as a string)
    # msg.to_mllp # mllp version of the message (as a string)
  end

  post '/' do
    # create a message from params
    msg = HL7::Message.new(params[:msg])

    # output message received
    msg.inspect
  end
end
