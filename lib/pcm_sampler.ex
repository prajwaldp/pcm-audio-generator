defmodule PcmSampler do
  @sample_rate 16_000
  @max_amplitude 32_767

  def sample(oscillator = %SinWave{}, duration) do
    num_samples = trunc(@sample_rate * duration)

    pre_data = for sample_number <- 1..num_samples do
      value = @max_amplitude * SinWave.value_at(oscillator, sample_number / @sample_rate)
      |> trunc

      << value :: big-signed-integer-size(16) >>
    end

    IO.iodata_to_binary(pre_data)
  end
end
