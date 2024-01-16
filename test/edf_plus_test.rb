# frozen_string_literal: true

require "test_helper"
require "tempfile"

# Test to assure EDF+s can be loaded and updated.
class EdfPlusTest < Minitest::Test

  def setup
    @edf_plus_with_signals = Edfize::EdfPlus.new("test/support/ma0844az_1-1+.edf")
    @edf_plus_artificial = Edfize::EdfPlus.new("test/support/test_generator_2.edf")
  end

  def test_edf_plus_version
    assert_equal 0, @edf_plus_with_signals.send("compute_offset", :version)
    assert_equal 0, @edf_plus_with_signals.version
    assert_equal 0, @edf_plus_artificial.send("compute_offset", :version)
    assert_equal 0, @edf_plus_artificial.version
  end

  def test_edf_plus_local_patient_identification
    assert_equal 8, @edf_plus_with_signals.send("compute_offset", :local_patient_identification)
    assert_equal "1234567 M 09-APR-1955 L._Smith", @edf_plus_with_signals.local_patient_identification
    assert_equal 8, @edf_plus_artificial.send("compute_offset", :local_patient_identification)
    assert_equal "X X X X", @edf_plus_artificial.local_patient_identification
  end

  def test_edf_plus_local_recording_identification
    assert_equal 88, @edf_plus_with_signals.send("compute_offset", :local_recording_identification)
    assert_equal "Startdate 15-SEP-2005 2 Kesteren Nihon_Kohden_EEG-1100C_V01.00", @edf_plus_with_signals.local_recording_identification
    assert_equal 88, @edf_plus_artificial.send("compute_offset", :local_recording_identification)
    assert_equal "Startdate 10-DEC-2009 X X test_generator", @edf_plus_artificial.local_recording_identification
  end

  def test_edf_plus_start_date_of_recording
    assert_equal 168, @edf_plus_with_signals.send("compute_offset", :start_date_of_recording)
    assert_equal "15.09.05", @edf_plus_with_signals.start_date_of_recording
    assert_equal 168, @edf_plus_artificial.send("compute_offset", :start_date_of_recording)
    assert_equal "10.12.09", @edf_plus_artificial.start_date_of_recording
  end

  def test_edf_plus_start_date
    assert_equal Date.parse("2005-09-15"), @edf_plus_with_signals.start_date
    assert_equal Date.parse("2009-12-10"), @edf_plus_artificial.start_date
  end

  def test_edf_plus_start_time_of_recording
    assert_equal 176, @edf_plus_with_signals.send("compute_offset", :start_time_of_recording)
    assert_equal "10.18.42", @edf_plus_with_signals.start_time_of_recording
    assert_equal 176, @edf_plus_artificial.send("compute_offset", :start_time_of_recording)
    assert_equal "12.44.02", @edf_plus_artificial.start_time_of_recording
  end

  def test_edf_plus_number_of_bytes_in_header
    assert_equal 184, @edf_plus_with_signals.send("compute_offset", :number_of_bytes_in_header)
    assert_equal 9984, @edf_plus_with_signals.number_of_bytes_in_header
    assert_equal 184, @edf_plus_artificial.send("compute_offset", :number_of_bytes_in_header)
    assert_equal 3328, @edf_plus_artificial.number_of_bytes_in_header
  end

  def test_edf_plus_reserved
    assert_equal 192, @edf_plus_with_signals.send("compute_offset", :reserved)
    assert_match /EDF\+[CD]/, @edf_plus_with_signals.reserved
    assert_equal 192, @edf_plus_artificial.send("compute_offset", :reserved)
    assert_match /EDF\+[CD]/, @edf_plus_artificial.reserved
  end

  def test_edf_plus_number_of_data_records
    assert_equal 236, @edf_plus_with_signals.send("compute_offset", :number_of_data_records)
    assert_equal 18181, @edf_plus_with_signals.number_of_data_records
    assert_equal 236, @edf_plus_artificial.send("compute_offset", :number_of_data_records)
    assert_equal 600, @edf_plus_artificial.number_of_data_records
  end

  def test_edf_plus_duration_of_a_data_record
    assert_equal 244, @edf_plus_with_signals.send("compute_offset", :duration_of_a_data_record)
    # there is no way
    assert_equal 0, @edf_plus_with_signals.duration_of_a_data_record
    assert_equal 244, @edf_plus_artificial.send("compute_offset", :duration_of_a_data_record)
    assert_equal 1, @edf_plus_artificial.duration_of_a_data_record
  end

  def test_edf_plus_number_of_signals
    assert_equal 252, @edf_plus_with_signals.send("compute_offset", :number_of_signals)
    assert_equal 38, @edf_plus_with_signals.number_of_signals
    assert_equal 252, @edf_plus_artificial.send("compute_offset", :number_of_signals)
    assert_equal 12, @edf_plus_artificial.number_of_signals
  end

end
