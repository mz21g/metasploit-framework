# -*- coding:binary -*-

require 'spec_helper'

RSpec.describe Rex::Proto::Kerberos::Model::KrbCred do
  let(:sample_kirbi) do
    "\x76\x82\x04\x90\x30\x82\x04\x8c\xa0\x03\x02\x01\x05\xa1\x03\x02" \
    "\x01\x16\xa2\x82\x03\xa4\x30\x82\x03\xa0\x61\x82\x03\x9c\x30\x82" \
    "\x03\x98\xa0\x03\x02\x01\x05\xa1\x0a\x1b\x08\x44\x57\x2e\x4c\x4f" \
    "\x43\x41\x4c\xa2\x28\x30\x26\xa0\x03\x02\x01\x01\xa1\x1f\x30\x1d" \
    "\x1b\x08\x4d\x53\x53\x71\x6c\x53\x76\x63\x1b\x11\x64\x63\x31\x2e" \
    "\x64\x77\x2e\x6c\x6f\x63\x61\x6c\x3a\x31\x34\x33\x33\xa3\x82\x03" \
    "\x59\x30\x82\x03\x55\xa0\x03\x02\x01\x17\xa1\x03\x02\x01\x02\xa2" \
    "\x82\x03\x47\x04\x82\x03\x43\x7f\x40\xc8\x2f\x79\x86\x30\xbd\x95" \
    "\x33\x72\x08\xd2\x30\x2a\x07\x42\x0d\xd9\x2c\xb2\x1b\x20\x19\xdf" \
    "\x78\x35\x56\x4f\x78\xa9\x91\x92\xbd\x34\x73\x88\xd5\x21\x19\x3b" \
    "\xa4\x9e\xb9\x08\x0f\x49\x1e\x4e\x6c\x6f\xa5\x68\x20\xc5\xc8\x8e" \
    "\xa0\x8e\x3d\xc6\x58\x50\x25\x7a\x09\xab\x76\x39\xb1\xde\x38\xc7" \
    "\xa9\xc2\xc2\xa0\x42\x7a\x69\xe2\xb2\x77\x51\x08\xf2\x14\x67\x48" \
    "\x60\xbf\xa4\x6f\x9d\x95\x53\x00\x76\x41\xf9\x06\xac\xab\xb3\x3c" \
    "\xfb\x9b\x93\x2b\x1b\x18\x35\x56\x00\xa0\x6a\x81\x06\x2c\x41\x6e" \
    "\xbb\xff\x72\xae\x04\xe7\x49\x6d\xa5\xe1\x80\xef\x58\xca\xfe\x67" \
    "\xbb\x56\xff\xaf\x1a\xe8\x34\xc9\x72\x72\x45\x20\x55\xe1\x52\xc8" \
    "\x01\xcc\x72\xfe\xdf\x8b\x2c\x2d\x6c\x48\x63\xc4\x7f\x3f\xeb\x13" \
    "\x05\xea\x32\xf8\x69\xaa\x57\x6d\x55\x35\x7f\xbd\x7d\xdc\xf7\xe2" \
    "\x23\xf3\xd8\xd4\xc1\x78\x06\x33\x2f\x17\x36\x01\x6a\x1b\xdc\xa5" \
    "\xc5\x90\x69\x7e\x45\xf1\x9d\xcc\x1d\x14\x6f\x5f\x9f\x52\x60\x77" \
    "\x36\x77\xc7\x9a\x6a\x12\xfa\x7d\x2c\x6f\x2f\x75\x57\xc1\xe4\x1b" \
    "\x55\xa8\xd1\x3f\x35\xc3\xe6\x54\xf4\xa1\x02\xd3\xb8\xc1\xdc\xc6" \
    "\x55\x76\xfd\x7d\xfb\xdc\x7d\x54\xd8\xfb\x3d\xc4\x8b\x2e\xe0\x1a" \
    "\x11\xd0\x57\x5a\x77\x18\x87\x41\x63\x65\x82\x4c\xb8\x06\x4f\x87" \
    "\x04\xef\x05\x39\xec\xa1\x3e\x79\xc1\xbd\x10\x6d\x57\x6d\x3c\xbc" \
    "\x27\x1a\xe8\x40\xe3\x36\xf2\x28\x98\x45\xc0\xcd\x05\xf4\x75\xd4" \
    "\xed\x47\xb2\x3e\x8b\x03\xac\x4f\x9e\xa4\x11\x21\xe9\x40\x8f\x8c" \
    "\x3b\x5d\x3b\xba\xf7\xb1\x08\xc3\xa7\x2f\x4f\xa4\x9a\x52\x76\xa0" \
    "\x6e\xfa\x59\x73\x4f\xde\xa8\x95\xa0\x4f\x2b\xde\xb9\xdf\xc6\x8c" \
    "\xec\x22\x54\xba\x2a\xcb\xf1\x41\xae\xf3\x7c\xa2\x44\x69\xb4\x2c" \
    "\x90\xe5\xbc\x90\xcb\x66\xf8\x0c\x22\x82\x79\x48\x4d\x9a\xc6\xae" \
    "\xe0\x02\x46\xa9\x9c\x16\xe7\xe3\x44\x0c\x0e\xcd\x5b\x9b\x24\x32" \
    "\x71\xd8\x22\xd1\x06\x54\xc0\xb3\x6a\xb9\x0c\xb6\x07\x4b\x50\x3f" \
    "\x8a\xe5\x6e\xf3\x07\xf6\x8c\xe8\xdc\xca\xbc\x18\x68\x06\xfc\xee" \
    "\x01\x3e\xc8\x1a\x01\x3c\x8e\xb9\xdb\xaa\xf3\x50\xed\x39\x08\x15" \
    "\x36\xb7\xba\x24\x85\x29\x66\xd5\x52\x14\x56\x32\xd0\xfe\xe0\xd3" \
    "\xd4\x4c\x62\xa2\x94\x40\x7d\x25\x3e\x89\xf0\xf5\xaf\x7b\xa4\x3f" \
    "\xb4\x85\x47\x57\x2f\x44\x3e\x00\x34\xa4\x92\x0f\xca\x1a\x10\x36" \
    "\x8f\x93\x34\xa6\x52\xca\xcc\x7f\x90\xa9\xa4\xc0\xfd\x49\xb9\xdb" \
    "\xbc\xc3\x28\x28\x7e\xa0\x2b\xa9\x6a\xa1\xca\xca\x26\x6d\x17\xc3" \
    "\x62\xcc\x3f\x52\x9a\x1e\xb3\x7f\xc5\xf7\xdd\x20\xfa\xd6\xe2\x8f" \
    "\xb2\x11\xc1\x88\xb9\xf9\x0e\x95\x5e\x03\xea\xbb\x8f\xee\x08\xda" \
    "\xb4\x72\xbd\x15\x52\x4e\xcf\xcc\x8c\x91\xa7\xdd\x6b\x27\x1d\xe3" \
    "\x0a\x9e\x7f\xd5\x40\x2b\x13\xea\x31\x4c\xb6\x7c\xf1\xa9\x07\xd6" \
    "\xeb\xb1\xe4\x89\x9b\xaa\xd3\xf7\x87\x00\x0c\xcf\x25\xee\xae\x70" \
    "\x52\xe5\x2b\x34\xcd\x30\xf9\xf7\x73\xe2\xc0\xf7\xfb\xb8\xe8\x91" \
    "\x94\xcf\x88\x27\x34\xdb\x3a\xdf\xb0\xf3\x3a\xb6\xec\x73\x51\xd8" \
    "\xa5\xfe\x42\xb3\xce\x54\x77\xec\x14\xeb\x90\x77\xe7\x9c\x22\xbe" \
    "\x59\xe0\x2c\xd8\xf1\x14\xf8\x0a\x7a\xd3\xe5\xf3\x81\x78\xf4\x7a" \
    "\x1e\xe1\xda\xb8\xb0\xf9\xbe\xc5\x56\x21\x2d\x6e\x19\x8b\xb3\xbe" \
    "\xd8\x1b\x7b\x75\x07\xa2\x66\x61\x2f\x59\x32\x91\xa8\x7b\xe2\x20" \
    "\xbc\xa5\x27\xd3\xd8\x80\x90\x6f\x02\xf3\xcc\x8f\xdd\x70\xdd\x38" \
    "\x1f\x70\xb6\xfa\x56\x05\xbc\x8b\x30\xc4\x73\xf0\x6c\xd4\x5f\x66" \
    "\xe4\xa8\xfb\xda\x3f\xef\x9f\x9e\xba\xbc\x22\xb3\x32\x42\xc2\x4f" \
    "\x88\xf7\x20\xf7\x04\x82\x38\xd1\xc0\x8f\xef\xc7\xa0\xd1\xdb\xdf" \
    "\x06\x5a\xe0\x2a\xe5\xe6\x87\x87\x97\x65\xe0\x3b\x02\xe0\x9b\xd6" \
    "\x05\x99\xe8\x2e\xef\xad\x0c\x99\xc5\x53\x09\xef\x8e\x8f\x4c\x54" \
    "\xe2\xac\xc2\x66\xfb\x2e\x22\x2c\xe7\x37\xf1\xb7\x57\x2a\x61\x19" \
    "\xba\xa2\xc6\x67\x8c\xc5\xb8\x1a\x5e\xed\xa3\x81\xd7\x30\x81\xd4" \
    "\xa0\x03\x02\x01\x00\xa2\x81\xcc\x04\x81\xc9\x7d\x81\xc6\x30\x81" \
    "\xc3\xa0\x81\xc0\x30\x81\xbd\x30\x81\xba\xa0\x1b\x30\x19\xa0\x03" \
    "\x02\x01\x17\xa1\x12\x04\x10\x70\x74\x58\x44\x6c\x73\x44\x78\x4d" \
    "\x4e\x6a\x48\x71\x65\x4a\x70\xa1\x0a\x1b\x08\x44\x57\x2e\x4c\x4f" \
    "\x43\x41\x4c\xa2\x17\x30\x15\xa0\x03\x02\x01\x01\xa1\x0e\x30\x0c" \
    "\x1b\x0a\x66\x61\x6b\x65\x5f\x6d\x79\x73\x71\x6c\xa3\x07\x03\x05" \
    "\x01\xa1\x40\x00\x00\xa5\x11\x18\x0f\x32\x30\x32\x32\x30\x38\x30" \
    "\x38\x31\x33\x30\x32\x35\x38\x5a\xa6\x11\x18\x0f\x32\x30\x33\x32" \
    "\x30\x38\x30\x35\x31\x33\x30\x32\x35\x38\x5a\xa7\x11\x18\x0f\x32" \
    "\x30\x33\x32\x30\x38\x30\x35\x31\x33\x30\x32\x35\x38\x5a\xa8\x0a" \
    "\x1b\x08\x44\x57\x2e\x4c\x4f\x43\x41\x4c\xa9\x28\x30\x26\xa0\x03" \
    "\x02\x01\x01\xa1\x1f\x30\x1d\x1b\x08\x4d\x53\x53\x71\x6c\x53\x76" \
    "\x63\x1b\x11\x64\x63\x31\x2e\x64\x77\x2e\x6c\x6f\x63\x61\x6c\x3a" \
    "\x31\x34\x33\x33"
  end

  subject(:krb_cred) do
    Rex::Proto::Kerberos::Model::KrbCred.decode(sample_kirbi)
  end

  describe '#decode' do
    it { is_expected.to be_a(Rex::Proto::Kerberos::Model::KrbCred) }
    it { expect(subject.pvno).to eq(5) }
    it { expect(subject.msg_type).to eq(22) }
    it { expect(subject.tickets).to be_an(Array) }
    it { expect(subject.tickets.length).to be(1) }
    it { expect(subject.tickets).to all be_a(Rex::Proto::Kerberos::Model::Ticket) }
    it { expect(subject.enc_part).to be_an(Rex::Proto::Kerberos::Model::EncryptedData) }
    it "successfully decodes the EncKrbCredPart" do
      enc_krb_part = Rex::Proto::Kerberos::Model::EncKrbCredPart.decode(subject.enc_part.cipher)
      expect(enc_krb_part).to be_an(Rex::Proto::Kerberos::Model::EncKrbCredPart)
    end
  end

  describe '#save_credential_to_file' do
    let(:kirbi_file) { Tempfile.new('test_kirbi_file_save.kirbi') }

    it { expect { subject.save_credential_to_file(kirbi_file.path) }.not_to raise_error }
  end

  describe '.load_credential_from_file' do
    let(:kirbi_file) do
      Tempfile.new('test_kirbi_file_save.kirbi').tap do |f|
        f << sample_kirbi
        f.close
      end
    end

    subject(:krb_cred) do
      Rex::Proto::Kerberos::Model::KrbCred.load_credential_from_file(kirbi_file.path)
    end

    it { is_expected.to be_a(Rex::Proto::Kerberos::Model::KrbCred) }
    it { expect(subject.pvno).to eq(5) }
    it { expect(subject.msg_type).to eq(22) }
    it { expect(subject.tickets).to be_an(Array) }
    it { expect(subject.tickets.length).to be(1) }
    it { expect(subject.tickets).to all be_a(Rex::Proto::Kerberos::Model::Ticket) }
    it { expect(subject.enc_part).to be_an(Rex::Proto::Kerberos::Model::EncryptedData) }

  end

  describe '#encode' do
    it { expect(krb_cred.encode).to eq(sample_kirbi) }
  end
end
