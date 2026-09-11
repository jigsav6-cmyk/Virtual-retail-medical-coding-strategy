def suggest_icd(text):
    text = text.lower()
    mapping = {'diabetes':'E11.9','fever':'R50.9','hypertension':'I10','cold':'J00','cough':'R05'}
    return [icd for k,icd in mapping.items() if k in text]

def suggest_cpt(encounter_type, duration):
    if encounter_type == 'video':
        return '99213 + 95 + POS 10'
    elif encounter_type == 'chat':
        if 5 <= duration <= 10: return '99421'
        elif 11 <= duration <= 20: return '99422'
        else: return '99423'
    return '99212'

def pos_logic(loc):
    return '10' if loc == 'home' else '02'

print(suggest_icd("Patient has diabetes and fever"))
print(suggest_cpt('video', 25))