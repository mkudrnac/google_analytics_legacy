class ZZD {
  static String zzd(int var0) {
    return _zza("&cd", var0);
  }

  static String zze(int var0) {
    return _zza("cd", var0);
  }

  static String zzf(int var0) {
    return _zza("&cm", var0);
  }

  static String zzg(int var0) {
    return _zza("cm", var0);
  }

  static String zzh(int var0) {
    return _zza("&pr", var0);
  }

  static String zzi(int var0) {
    return _zza("pr", var0);
  }

  static String zzj(int var0) {
    return _zza("&promo", var0);
  }

  static String zzk(int var0) {
    return _zza("promo", var0);
  }

  static String zzl(int var0) {
    return _zza("pi", var0);
  }

  static String zzm(int var0) {
    return _zza("&il", var0);
  }

  static String zzn(int var0) {
    return _zza("il", var0);
  }

  static String zzo(int var0) {
    return _zza("cd", var0);
  }

  static String zzp(int var0) {
    return _zza("cm", var0);
  }

  static String _zza(String var0, int var1) {
    if (var1 <= 0) {
      assert(false, "index out of range for prefix " + var0);
      return "";
    } else {
      return "11" + "${var0.length}" + var0 + var1.toString();
    }
  }
}
