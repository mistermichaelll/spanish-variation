module CorpusHelpers

using DataFrames: DataFrame

@kwdef struct CorpusParticipant
    ID::String
    Age::Int
    Sex::String
    BirthPlace::String
    Studies::String
    Job::String
    YearsInUS::Int
    YearsInVirginia::Int
    SpeakerType::String
    generate_participant_row::Function = function()
        DataFrame(
            "id" => ID,
            "age" => Age,
            "sex" => Sex,
            "birthplace" => BirthPlace,
            "studies" => Studies,
            "job" => Job,
            "years_in_us" => YearsInUS,
            "years_in_virginia" => YearsInVirginia,
            "speaker_type" => SpeakerType
        )
    end
end

function read_interview(path::String)
    interview_text = read(path)
    lines = split(String(interview_text), '\r')

    lines_filtered = filter(
        x -> x != " " && x != "",
        lines
    )

    return lines_filtered
end

function parse_lines_to_q_a(interview_text)
    interviewer_questions = []
    participant_answers = []

    current_segment = ""
    current_role = ""

    for line in interview_text
        if startswith(lowercase(line), "entrevistador")
            if current_role == "participante"
                # If a line starts with "Entrevistador," it's a new question
                push!(
                    participant_answers,
                    replace(current_segment, r"Participante\s+" => "")
                )
                current_segment = ""
            end
            current_role = "entrevistador"
        elseif startswith(lowercase(line), "participante")
            if current_role == "entrevistador"
                # If a line starts with "Participante," it's a new answer
                push!(
                    interviewer_questions,
                    replace(current_segment, r"Entrevistador\s+" => "")
                )
                current_segment = ""
            end
            current_role = "participante"
        end
        # Append the current line to the segment
        current_segment *= line
    end

    if current_role == "entrevistador"
        push!(interviewer_questions, current_segment)
    else
        push!(participant_answers, current_segment)
    end

    interviewer_questions, participant_answers
end

export CorpusParticipant, generate_participant_row, parse_lines_to_q_a, read_interview
end
