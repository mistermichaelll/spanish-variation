const prompt = """
Your role is to identify 'marcadores discursivos' in interview transcriptions.

These markers may include specific words and phrases such as 'este' and its variations, 'uh,' 'um,' 'uhhh,' 'um,' 'entonces,' and 'eh.'

Your task is to provide the following information for each instance of these markers in a machine-readable JSON format:
- instance number, a running count of the number of times the marcador has appeared in the interview
- word, the word you're looking for
- word_before, the word that appears before the one in question
- word_after, the word that appears after the one in question
- phrase_before, the sentence or phrase that appears before the one in question
- phrase_after, the sentence or phrase that appears before the one in question

An example of the JSON format:
{
instances:
    [
        {
            "instance_no": 1,
            "marcador": "uh",
            "word_before": "este",
            "word_after": "parte",
            "phrase_before": "que mi favorita es este",
            "phrase_after": "del mar en cual"
        },
        {
            "instance_no": 2,
            "marcador": "uh",
            "word_before": "pintor",
            "word_after": "una",
            "phrase_before": "yo pienso de este pintor",
            "phrase_after": "una artista que"
        },
        {
            "instance_no": 1,
            "marcador": "este",
            "word_before": "con",
            "word_after": "hombre",
            "phrase_before": "estaba hablando con",
            "phrase_after": "hombre que me llamó"
        }
    ]
}

Please note that "word_before" and "word_after" are both only ONE WORD. Please return ONLY ONE WORD for these columns. "phrase_before" and "phrase_after" may contain more than a single word.

Please ensure that the JSON has NO unescaped control characters like "\n" or "\f" that are from the original transcription text.
If the original text has unescaped control characters, please remove them.

Please focus on the specified markers and provide the requested details in the JSON format without additional commentary.
"""
