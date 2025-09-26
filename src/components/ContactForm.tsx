import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useToast } from "@/hooks/use-toast";
import { validateCPF } from "@/lib/cpf-validator";
import { supabase } from "@/integrations/supabase/client";
import bravoBetLogo from "@/assets/bravo-bet-logo.png";

const formSchema = z.object({
  name: z
    .string()
    .trim()
    .min(2, { message: "Nome deve ter pelo menos 2 caracteres" })
    .max(100, { message: "Nome deve ter no máximo 100 caracteres" }),
  cpf: z
    .string()
    .trim()
    .refine(validateCPF, { message: "CPF inválido" }),
  phone: z
    .string()
    .trim()
    .regex(/^\(\d{2}\)\s\d{4,5}-\d{4}$/, { message: "Formato: (11) 99999-9999" }),
  email: z
    .string()
    .trim()
    .email({ message: "Email inválido" })
    .max(255, { message: "Email deve ter no máximo 255 caracteres" }),
});

type FormData = z.infer<typeof formSchema>;

export default function ContactForm() {
  const [isSubmitting, setIsSubmitting] = useState(false);
  const { toast } = useToast();
  
  const {
    register,
    handleSubmit,
    formState: { errors },
    reset,
    watch,
    setValue,
  } = useForm<FormData>({
    resolver: zodResolver(formSchema),
    mode: "onChange",
  });

  const formatCPF = (value: string) => {
    const numbers = value.replace(/\D/g, "");
    return numbers.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, "$1.$2.$3-$4");
  };

  const formatPhone = (value: string) => {
    const numbers = value.replace(/\D/g, "");
    if (numbers.length <= 10) {
      return numbers.replace(/(\d{2})(\d{4})(\d{4})/, "($1) $2-$3");
    }
    return numbers.replace(/(\d{2})(\d{5})(\d{4})/, "($1) $2-$3");
  };


  const onSubmit = async (data: FormData) => {
    setIsSubmitting(true);
    
    try {
      // Save to Supabase database
      const { error } = await supabase
        .from('event_registrations')
        .insert({
          nome: data.name,
          cpf: data.cpf,
          telefone: data.phone,
          email: data.email,
          ip_address: null // Could be collected from a backend service if needed
        });

      if (error) {
        throw error;
      }
      
      toast({
        title: "🎉 Cadastro realizado com sucesso!",
        description: `Parabéns, ${data.name}! Sua vaga no evento Conversão Digital foi reservada. Você receberá mais informações em breve.`,
      });
      
      reset();
    } catch (error) {
      console.error('Error saving registration:', error);
      toast({
        title: "❌ Erro ao enviar formulário",
        description: "Ocorreu um erro ao processar seu cadastro. Tente novamente em alguns minutos.",
        variant: "destructive",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-background via-accent/20 to-primary/5 flex items-center justify-center p-4">
      <Card className="w-full max-w-md shadow-xl border-0 bg-card/95 backdrop-blur-sm">
        <CardHeader className="text-center pb-6">
          <div className="flex justify-center mb-4">
            <img 
              src={bravoBetLogo} 
              alt="BRAVO BET Logo" 
              className="h-12 w-auto"
            />
          </div>
          <CardTitle className="text-2xl font-semibold bg-gradient-to-r from-primary to-primary-glow bg-clip-text text-transparent">
            Cadastro para o Evento
          </CardTitle>
          <div className="bg-gradient-to-r from-primary to-primary-glow p-3 rounded-lg mt-2">
            <h2 className="text-lg font-semibold text-white text-center">
              Conversão Digital
            </h2>
          </div>
        </CardHeader>
        
        <CardContent className="space-y-6">
          <form onSubmit={handleSubmit(onSubmit)} className="space-y-5">
            <div className="space-y-2">
              <Label htmlFor="name" className="text-sm font-medium">
                Nome completo
              </Label>
              <Input
                id="name"
                {...register("name")}
                placeholder="Digite seu nome completo"
                className={`transition-all duration-200 ${
                  errors.name ? "border-destructive focus-visible:ring-destructive" : ""
                }`}
              />
              {errors.name && (
                <p className="text-xs text-destructive animate-in slide-in-from-left-2">
                  {errors.name.message}
                </p>
              )}
            </div>

            <div className="space-y-2">
              <Label htmlFor="cpf" className="text-sm font-medium">
                CPF
              </Label>
              <Input
                id="cpf"
                {...register("cpf")}
                placeholder="000.000.000-00"
                maxLength={14}
                onChange={(e) => {
                  const formatted = formatCPF(e.target.value);
                  setValue("cpf", formatted);
                }}
                className={`transition-all duration-200 ${
                  errors.cpf ? "border-destructive focus-visible:ring-destructive" : ""
                }`}
              />
              {errors.cpf && (
                <p className="text-xs text-destructive animate-in slide-in-from-left-2">
                  {errors.cpf.message}
                </p>
              )}
            </div>

            <div className="space-y-2">
              <Label htmlFor="phone" className="text-sm font-medium">
                Telefone
              </Label>
              <Input
                id="phone"
                {...register("phone")}
                placeholder="(11) 99999-9999"
                maxLength={15}
                onChange={(e) => {
                  const formatted = formatPhone(e.target.value);
                  setValue("phone", formatted);
                }}
                className={`transition-all duration-200 ${
                  errors.phone ? "border-destructive focus-visible:ring-destructive" : ""
                }`}
              />
              {errors.phone && (
                <p className="text-xs text-destructive animate-in slide-in-from-left-2">
                  {errors.phone.message}
                </p>
              )}
            </div>

            <div className="space-y-2">
              <Label htmlFor="email" className="text-sm font-medium">
                Email
              </Label>
              <Input
                id="email"
                type="email"
                {...register("email")}
                placeholder="seu@email.com"
                className={`transition-all duration-200 ${
                  errors.email ? "border-destructive focus-visible:ring-destructive" : ""
                }`}
              />
              {errors.email && (
                <p className="text-xs text-destructive animate-in slide-in-from-left-2">
                  {errors.email.message}
                </p>
              )}
            </div>

            <Button 
              type="submit" 
              className="w-full h-11 mt-8"
              variant="gradient"
              disabled={isSubmitting}
            >
              {isSubmitting ? "Processando cadastro..." : "Garantir minha vaga"}
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}