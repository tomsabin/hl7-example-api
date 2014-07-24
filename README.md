#SH24 HL7 API

Built with [Grape](https://github.com/intridea/grape)

##Get started

- Run the server with `rackup`

##Routes

- `GET /` responds with example HL7 message
  - `curl http://localhost:9292/`

- `POST /` with param `msg` will create a HL7::Message object
  - `curl -d 'msg=MSH||||ruby hl7|my office|||||1337' 'http://localhost:9292/'`
  - segments need to be separated by `\r`

##[ruby-hl7](http://rubydoc.info/gems/ruby-hl7/1.0.3/frames)

- [HL7 Information by Interfaceware](http://www.interfaceware.com/blog/category/hl7-info/)
- [HL7::Message](http://rubydoc.info/gems/ruby-hl7/1.0.3/HL7/Message)
- [HL7::Message::Segment](http://rubydoc.info/gems/ruby-hl7/1.0.3/HL7/Message/Segment)

###Example HL7::Message object:

    #<HL7::Message:0x007fb693981c18
     @element_delim="|",
     @item_delim="|",
     @parsing=nil,
     @segment_delim="\r",
     @segments=
      [#<HL7::Message::Segment::MSH:0x007fb693980e80
        @element_delim="|",
        @elements=["MSH", "", "", "", "ruby hl7", "my office", "", "", "", "", "9377"],
        @field_total=0,
        @is_child=false,
        @item_delim="|",
        @segment_parent=#<HL7::Message:0x007fb693981c18 ...>,
        @segments_by_name={}>],
     @segments_by_name=
      {:MSH=>
        [#<HL7::Message::Segment::MSH:0x007fb693980e80
          @element_delim="|",
          @elements=["MSH", "", "", "", "ruby hl7", "my office", "", "", "", "", "9377"],
          @field_total=0,
          @is_child=false,
          @item_delim="|",
          @segment_parent=#<HL7::Message:0x007fb693981c18 ...>,
          @segments_by_name={}>]}>
