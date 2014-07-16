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
    output = {}
    msh = params[:msg]
    evn = params[:msg].split('EVN').drop(1).map{|s| 'EVN'+s}
    msa = params[:msg].split('MSA').drop(1).map{|s| 'MSA'+s}
    nte = params[:msg].split('NTE').drop(1).map{|s| 'NTE'+s}
    obr = params[:msg].split('OBR').drop(1).map{|s| 'OBR'+s}
    obx = params[:msg].split('OBX').drop(1).map{|s| 'OBX'+s}
    orc = params[:msg].split('ORC').drop(1).map{|s| 'ORC'+s}
    oru = params[:msg].split('ORU').drop(1).map{|s| 'ORU'+s}
    pid = params[:msg].split('PID').drop(1).map{|s| 'PID'+s}
    pv1 = params[:msg].split('PV1').drop(1).map{|s| 'PV1'+s}
    pv2 = params[:msg].split('PV2').drop(1).map{|s| 'PV2'+s}
    qrd = params[:msg].split('QRD').drop(1).map{|s| 'QRD'+s}
    qrf = params[:msg].split('QRF').drop(1).map{|s| 'QRF'+s}
    msg = HL7::Message.new(msh)
    msg << HL7::Message::Segment::EVN.new(evn.first) unless evn.empty?
    msg << HL7::Message::Segment::MSA.new(msa.first) unless msa.empty?
    msg << HL7::Message::Segment::NTE.new(nte.first) unless nte.empty?
    msg << HL7::Message::Segment::OBR.new(obr.first) unless obr.empty?
    msg << HL7::Message::Segment::OBX.new(obx.first) unless obx.empty?
    msg << HL7::Message::Segment::ORC.new(orc.first) unless orc.empty?
    msg << HL7::Message::Segment::ORU.new(oru.first) unless oru.empty?
    msg << HL7::Message::Segment::PID.new(pid.first) unless pid.empty?
    msg << HL7::Message::Segment::PV1.new(pv1.first) unless pv1.empty?
    msg << HL7::Message::Segment::PV2.new(pv2.first) unless pv2.empty?
    msg << HL7::Message::Segment::QRD.new(qrd.first) unless qrd.empty?
    msg << HL7::Message::Segment::QRF.new(qrf.first) unless qrf.empty?

    # https://github.com/segfault/ruby-hl7/blob/master/lib/segments/msh.rb
    output[:msh] = {
      enc_chars: msg[:MSH].enc_chars,
      sending_app: msg[:MSH].sending_app,
      sending_facility: msg[:MSH].sending_facility,
      recv_app: msg[:MSH].recv_app,
      recv_facility: msg[:MSH].recv_facility,
      time: msg[:MSH].time,
      security: msg[:MSH].security,
      message_type: msg[:MSH].message_type,
      message_control_id: msg[:MSH].message_control_id,
      processing_id: msg[:MSH].processing_id,
      version_id: msg[:MSH].version_id,
      seq: msg[:MSH].seq,
      continue_ptr: msg[:MSH].continue_ptr,
      accept_ack_type: msg[:MSH].accept_ack_type,
      app_ack_type: msg[:MSH].app_ack_type,
      country_code: msg[:MSH].country_code,
      charset: msg[:MSH].charset
    } if msg[:MSH].is_a?(HL7::Message::Segment::MSH)

    output[:pid] = {
      set_id: msg[:PID].set_id,
      patient_id: msg[:PID].patient_id,
      patient_id_list: msg[:PID].patient_id_list,
      alt_patient_id: msg[:PID].alt_patient_id,
      patient_name: msg[:PID].patient_name,
      mother_maiden_name: msg[:PID].mother_maiden_name,
      patient_dob: msg[:PID].patient_dob,
      patient_alias: msg[:PID].patient_alias,
      race: msg[:PID].race,
      address: msg[:PID].address,
      country_code: msg[:PID].country_code,
      phone_home: msg[:PID].phone_home,
      phone_business: msg[:PID].phone_business,
      primary_language: msg[:PID].primary_language,
      marital_status: msg[:PID].marital_status,
      religion: msg[:PID].religion,
      account_number: msg[:PID].account_number,
      social_security_num: msg[:PID].social_security_num,
      mothers_id: msg[:PID].mothers_id,
      ethnic_group: msg[:PID].ethnic_group,
      birthplace: msg[:PID].birthplace,
      multi_birth: msg[:PID].multi_birth,
      birth_order: msg[:PID].birth_order,
      citizenship: msg[:PID].citizenship,
      vet_status: msg[:PID].vet_status,
      nationality: msg[:PID].nationality,
      death_date: msg[:PID].death_date,
      death_indicator: msg[:PID].death_indicator,
      id_unknown_indicator: msg[:PID].id_unknown_indicator,
      id_readability_code: msg[:PID].id_readability_code,
      last_update_date: msg[:PID].last_update_date,
      last_update_facility: msg[:PID].last_update_facility,
      species_code: msg[:PID].species_code,
      breed_code: msg[:PID].breed_code,
      strain: msg[:PID].strain,
      production_class_code: msg[:PID].production_class_code,
      tribal_citizenship: msg[:PID].tribal_citizenship
    } if msg[:PID].is_a?(HL7::Message::Segment::PID)

    output.inspect
  end
end
