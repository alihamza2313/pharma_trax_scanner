
import 'package:pharma_trax_scanner/javacodes/aii_model.dart';
class GS1ParseEngine
{
    static Map aiiMap = Map();
    Map parsedMap = Map();
    String? error = '';

    GS1ParseEngine()
    {
        buildAiiMap();
    }

    // ignore: non_constant_identifier_names
    static void AddAI(String identifier, String title, int length)
    {
        aiiMap={"identifier":identifier,'AII': AII(title, '', length, length, false)};
    }

    // ignore: non_constant_identifier_names
    static void AddAII(String identifier, String title, int length, bool requiredFNC1)
    {
        aiiMap={"identifier":identifier,'AII': AII(title, '', length, length, requiredFNC1)};
    }

    static  void AddAIII(String identifier, String title, int minimumLength, int maximumLength)
    {
        aiiMap={"identifier":identifier,'AII': AII(title, '', minimumLength, maximumLength, true)};
    }

    static void AddAIIII(String identifier, String title, int minimumLength, int maximumLength, bool requiredFNC1)
    {
        aiiMap={"identifier":identifier,'AII': AII(title, '', minimumLength, maximumLength, requiredFNC1)};
    }

    static void buildAiiMap()
    {
        AddAI("00", "SSCC", 18);
        AddAI("01", "GTIN", 14);
        AddAI("02", "CONTENT", 14);
        AddAIII("10", "BATCH/LOT", 1, 20);
        AddAI("11", "PROD DATE", 6);
        AddAI("12", "DUE DATE", 6);
        AddAI("13", "PACK DATE", 6);
        AddAI("15", "BEST BY", 6);
        AddAI("16", "SELL BY", 6);
        AddAI("17", "EXPIRY", 6);
        AddAI("20", "VARIANT", 2);
        AddAIII("21", "SERIAL", 1, 20);
        AddAIII("22", "CPV", 1, 20);
        AddAIII("240", "ADDITIONAL ID", 1, 30);
        AddAIII("241", "CUST. PART NO.", 1, 30);
        AddAIII("242", "MTO VARIANT", 1, 30);
        AddAIII("243", "PCN", 1, 30);
        AddAIII("250", "SECONDARY SERIAL", 1, 30);
        AddAIII("251", "REF. TO SOURCE", 1, 30);
        AddAIII("253", "GDTI", 13, 30);
        AddAIII("254", "GLN EXTENSION COMPONENT", 1, 20);
        AddAIII("255", "GCN", 13, 25);
        AddAIII("30", "VAR. COUNT", 1, 8);
        AddAI("310n", "NET WEIGHT (kg)", 6);
        AddAI("311n", "LENGTH (m)", 6);
        AddAI("312n", "WIDTH (m)", 6);
        AddAI("313n", "HEIGHT (m)", 6);
        AddAI("314n", "AREA (m2)", 6);
        AddAI("315n", "NET VOLUME (l)", 6);
        AddAI("316n", "NET VOLUME (m3)", 6);
        AddAI("320n", "NET WEIGHT (lb)", 6);
        AddAI("321n", "LENGTH (i)", 6);
        AddAI("322n", "LENGTH (f)", 6);
        AddAI("323n", "LENGTH (y)", 6);
        AddAI("324n", "WIDTH (i)", 6);
        AddAI("325n", "WIDTH (f)", 6);
        AddAI("326n", "WIDTH (y)", 6);
        AddAI("327n", "HEIGHT (i)", 6);
        AddAI("328n", "HEIGHT (f)", 6);
        AddAI("329n", "HEIGHT (y)", 6);
        AddAI("330n", "GROSS WEIGHT (kg)", 6);
        AddAI("331n", "LENGTH (m), log", 6);
        AddAI("332n", "WIDTH (m), log", 6);
        AddAI("333n", "HEIGHT (m), log", 6);
        AddAI("334n", "AREA (m2), log", 6);
        AddAI("335n", "VOLUME (l), log", 6);
        AddAI("336n", "VOLUME (m3), log", 6);
        AddAI("337n", "KG PER m²", 6);
        AddAI("340n", "GROSS WEIGHT (lb)", 6);
        AddAI("341n", "LENGTH (i), log", 6);
        AddAI("342n", "LENGTH (f), log", 6);
        AddAI("343n", "LENGTH (y), log", 6);
        AddAI("344n", "WIDTH (i), log", 6);
        AddAI("345n", "WIDTH (f), log", 6);
        AddAI("346n", "WIDTH (y), log", 6);
        AddAI("347n", "HEIGHT (i), log", 6);
        AddAI("348n", "HEIGHT (f), log", 6);
        AddAI("349n", "HEIGHT (y), log", 6);
        AddAI("350n", "AREA (i2)", 6);
        AddAI("351n", "AREA (f2)", 6);
        AddAI("352n", "AREA (y2)", 6);
        AddAI("353n", "AREA (i2), log", 6);
        AddAI("354n", "AREA (f2), log", 6);
        AddAI("355n", "AREA (y2), log", 6);
        AddAI("356n", "NET WEIGHT (t)", 6);
        AddAI("357n", "NET VOLUME (oz)", 6);
        AddAI("360n", "NET VOLUME (q)", 6);
        AddAI("361n", "NET VOLUME (g)", 6);
        AddAI("362n", "VOLUME (q), log", 6);
        AddAI("363n", "VOLUME (g), log", 6);
        AddAI("364n", "VOLUME (i3)", 6);
        AddAI("365n", "VOLUME (f3)", 6);
        AddAI("366n", "VOLUME (y3)", 6);
        AddAI("367n", "VOLUME (i3), log", 6);
        AddAI("368n", "VOLUME (f3), log", 6);
        AddAI("369n", "VOLUME (y3), log", 6);
        AddAIII("37", "COUNT", 1, 8);
        AddAIII("390n", "AMOUNT", 1, 15);
        AddAIII("391n", "AMOUNT", 3, 18);
        AddAIII("392n", "PRICE", 1, 15);
        AddAIII("393n", "PRICE", 3, 18);
        AddAII("394n", "PRCNT OFF", 4, true);
        AddAIII("400", "ORDER NUMBER", 1, 30);
        AddAIII("401", "GINC", 1, 30);
        AddAII("402", "GSIN", 17, true);
        AddAIII("403", "ROUTE", 1, 30);
        AddAI("410", "SHIP TO LOC", 13);
        AddAI("411", "BILL TO", 13);
        AddAI("412", "PURCHASE FROM", 13);
        AddAI("413", "SHIP FOR LOC", 13);
        AddAI("414", "LOC No", 13);
        AddAI("415", "PAY TO", 13);
        AddAI("416", "PROD/SERV LOC", 13);
        AddAIII("420", "SHIP TO POST", 1, 20);
        AddAIII("421", "SHIP TO POST", 3, 12);
        AddAII("422", "ORIGIN", 3, true);
        AddAIII("423", "COUNTRY - INITIAL PROCESS.", 3, 15);
        AddAII("424", "COUNTRY - PROCESS.", 3, true);
        AddAIII("425", "COUNTRY - DISASSEMBLY", 3, 15);
        AddAII("426", "COUNTRY – FULL PROCESS", 3, true);
        AddAIII("427", "ORIGIN SUBDIVISION", 1, 3);
        AddAII("7001", "NSN", 13, true);
        AddAIII("7002", "MEAT CUT", 1, 30);
        AddAII("7003", "EXPIRY TIME", 10, true);
        AddAIII("7004", "ACTIVE POTENCY", 1, 4);
        AddAIII("7005", "CATCH AREA", 1, 12);
        AddAII("7006", "FIRST FREEZE DATE", 6, true);
        AddAIII("7007", "HARVEST DATE", 6, 12);
        AddAIII("7008", "AQUATIC SPECIES", 1, 3);
        AddAIII("7009", "FISHING GEAR TYPE", 1, 10);
        AddAIII("7010", "PROD METHOD", 1, 2);
        AddAIII("7020", "REFURB LOT", 1, 20);
        AddAIII("7021", "FUNC STAT", 1, 20);
        AddAIII("7022", "REV STAT", 1, 20);
        AddAIII("7023", "GIAI – ASSEMBLY", 1, 30);
        AddAIII("703s", "PROCESSOR # s", 3, 30);
        AddAIII("710", "NHRN PZN", 1, 20);
        AddAIII("711", "NHRN CIP", 1, 20);
        AddAIII("712", "NHRN CN", 1, 20);
        AddAIII("713", "NHRN DRN", 1, 20);
        AddAIII("714", "NHRN AIM", 1, 20);
        AddAIII("...", "NHRN xxx", 1, 20);
        AddAII("8001", "DIMENSIONS", 14, true);
        AddAIII("8002", "CMT No", 1, 20);
        AddAIII("8003", "GRAI", 14, 30);
        AddAIII("8004", "GIAI", 1, 30);
        AddAII("8005", "PRICE PER UNIT", 6, true);
        AddAII("8006", "ITIP or GCTIN", 18, true);
        AddAIII("8007", "IBAN", 1, 34);
        AddAIII("8008", "PROD TIME", 8, 12);
        AddAIII("8010", "CPID", 1, 30);
        AddAIII("8011", "CPID SERIAL", 1, 12);
        AddAIII("8012", "VERSION", 1, 20);
        AddAIII("8013", "GMN or BUDI-DI", 1, 30);
        AddAII("8017", "GSRN - PROVIDER", 18, true);
        AddAII("8018", "GSRN - RECIPIENT", 18, true);
        AddAIII("8019", "SRIN", 1, 10);
        AddAIII("8020", "REF No", 1, 25);
        AddAIII("8110", "-", 1, 70);
        AddAII("8111", "POINTS", 4, true);
        AddAIII("8112", "-", 1, 70);
        AddAIII("8200", "PRODUCT URL", 1, 70);
        AddAIII("90", "INTERNAL", 1, 30);
        AddAIII("91", "INTERNAL", 1, 90);
        AddAIII("92", "INTERNAL", 1, 90);
        AddAIII("93", "INTERNAL", 1, 90);
        AddAIII("94", "INTERNAL", 1, 90);
        AddAIII("95", "INTERNAL", 1, 90);
        AddAIII("96", "INTERNAL", 1, 90);
        AddAIII("97", "INTERNAL", 1, 90);
        AddAIII("98", "INTERNAL", 1, 90);
        AddAIII("99", "INTERNAL", 1, 90);
    }

    String getError()
    {
        return error!;
    }

    Map getParsedMap()
    {
        return parsedMap;
    }

    bool parseString(String s, int fnc1)
    {
        this.error = null;
        this.parsedMap.clear();
        StringBuffer stringBuilder = StringBuffer();
        int length = s.length;
        int index = 0;
        AII info;
        while (index < length) {
            int c = s.codeUnitAt(index++);
            if (c == fnc1) {
                this.error = ("Invalid FNC1 found at index " + index.toString());
                break;
            }
            stringBuilder.write(c);
            if (stringBuilder.length <= 4) {
                if (stringBuilder.length >= 2) {
                    String ai = stringBuilder.toString();
                    if (aiiMap.containsKey(ai)) {
                        info = aiiMap[ai];
                        StringBuffer value = StringBuffer();
                        bool checkFNC1 = false;
                        for (int i = 0; (i < info.getMaximumLength()) && (index < s.length); i++) {
                            int v = s.codeUnitAt(index++);
                            if (v == fnc1) {
                                checkFNC1 = true;
                                break;
                            }
                            value.write(v);
                        }
                        if (info.isRequiredFNC1()) {
                            if (!checkFNC1) {
                                if (index < length) {
                                    if (s.codeUnitAt(index) != fnc1) {
                                        this.error = ("FNC1 required at index " + index.toString());
                                        break;
                                    } else {
                                        index++;
                                    }
                                }
                            }
                        } else {
                            if (checkFNC1) {
                                error = ("Invalid FNC1 found at index " + (index - 1).toString());
                                break;
                            }
                        }
                        if (value.length < info.getMinimumLength()) {
                            this.error = (((("AI " + ai) + " should be at least ") + info.getMinimumLength().toString()) + " characters");
                            break;
                        }
                        parsedMap= {'ai':ai,'AII': AII(info.getTitle(), value.toString(), info.getMinimumLength(), info.getMaximumLength(), info.isRequiredFNC1())};
                        stringBuilder.writeln(0);
                    }
                }
            } else {
                this.error = (("AI " + stringBuilder.toString()) + " not found");
                break;
            }
        }
        // ignore: unnecessary_this
        if ((stringBuilder.length > 0) && (this.error == null)) {
            this.error = (("AI " + stringBuilder.toString()) + " not found");
        }
        return error == null;
    }
}