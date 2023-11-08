include("open-ai-helpers.jl")
include("corpus-helpers.jl")
include("prompt.jl")

using .CorpusHelpers
using DataFrames
using JSON3
using .OpenAIHelpers

participant_1 = CorpusParticipant(
    "MONO-016",
    21,
    "M",
    "Lima, Peru",
    "university-college",
    "skilled-worker",
    5,
    5,
    "first-generation"
)

participant_interview = read_interview("MONO-016.txt")
answers = parse_lines_to_q_a(participant_interview)[2]

sampled_answers = answers[1:15]
replace!(sampled_answers, "\f" => "") # causing some JSON funkiness in the API response.

input_message = Dict(
    "role" => "user",
    "content" => join(sampled_answers, "\n")
)

r = get_gpt_chat_completion(
    serialize_message_to_json(
        Dict("role" => "system", "content" => prompt),
        input_message
    ),
    model = "gpt-4-0613"
)

df = instances_to_df(r)

df_w_participant_info = crossjoin(generate_participant_row(participant_1), df)

df_w_participant_info
