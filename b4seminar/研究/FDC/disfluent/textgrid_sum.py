from tgt import read_textgrid
tg = read_textgrid("./disfluent/FAOMFUN1disfluency.TextGrid")
tier = tg.get_tier_by_name("disfluency")
from pandas import DataFrame
df = DataFrame([interval.text for interval in tier], columns=["words"])
df.words.value_counts()
tg2 = read_textgrid("./disfluent/FAOMFUN2disfluency.TextGrid")
tg2_part = tgt.TextGrid()
tier2 = tg2.get_tier_by_name("disfluency")
df2 = DataFrame([interval.text for interval in tier2], columns=["words"])
df2.words.value_counts()
