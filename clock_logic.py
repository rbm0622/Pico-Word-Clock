# clock_logic.py

def hour_to_word(hour):
    hour = hour % 12
    if hour == 0:
        hour = 12

    return {
        1: "ONE",
        2: "TWO",
        3: "THREE",
        4: "FOUR",
        5: "FIVE_H",
        6: "SIX",
        7: "SEVEN",
        8: "EIGHT",
        9: "NINE",
        10: "TEN_H",
        11: "ELEVEN",
        12: "TWELVE"
    }[hour]


def minute_to_words(minute):
    minute = int((minute + 2) / 5) * 5
    minute %= 60

    if minute == 0:
        return [], "OCLOCK"
    elif minute == 5:
        return ["FIVE_M"], "PAST"
    elif minute == 10:
        return ["TEN_M"], "PAST"
    elif minute == 15:
        return ["A", "QUARTER"], "PAST"
    elif minute == 20:
        return ["TWENTY"], "PAST"
    elif minute == 25:
        return ["TWENTY", "FIVE_M"], "PAST"
    elif minute == 30:
        return ["HALF"], "PAST"
    elif minute == 35:
        return ["TWENTY", "FIVE_M"], "TO"
    elif minute == 40:
        return ["TWENTY"], "TO"
    elif minute == 45:
        return ["A", "QUARTER"], "TO"
    elif minute == 50:
        return ["TEN_M"], "TO"
    elif minute == 55:
        return ["FIVE_M"], "TO"


def time_to_words(hour, minute):
    words = ["IT", "IS"]

    minute_words, relation = minute_to_words(minute)

    if relation == "OCLOCK":
        words.append(hour_to_word(hour))
        words.append("OCLOCK")
    else:
        if relation == "TO":
            hour += 1

        words.extend(minute_words)
        words.append(relation)
        words.append(hour_to_word(hour))

    # AM / PM
    if hour % 24 < 12:
        words.append("AM")
    else:
        words.append("PM")

    return words
