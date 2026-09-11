ndc_database = {
    "00123456701": {"drug": "Glucometer", "price": 800},
    "00123456702": {"drug": "Strips", "price": 300},
    "00123456703": {"drug": "Lancet", "price": 100}
}

def bundle_price():
    total = 800+300+100
    return {"individual": total, "bundle": 1200, "saving": total-1200}

def check_denial(claim):
    risks = []
    if not claim.get("modifier"): risks.append("HIGH: Modifier missing")
    if not claim.get("pos"): risks.append("HIGH: POS missing")
    return risks if risks else ["LOW RISK"]

print(bundle_price())
print(check_denial({"encounter":"video","modifier":"","pos":"10"}))