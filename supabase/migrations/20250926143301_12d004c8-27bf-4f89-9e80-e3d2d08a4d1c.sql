-- Enable Row Level Security on existing tables that don't have it
ALTER TABLE public.submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tickets ENABLE ROW LEVEL SECURITY;

-- Add basic policies for submissions table (anonymous insert, authenticated read)  
CREATE POLICY "Allow anonymous inserts for submissions" 
ON public.submissions 
FOR INSERT 
TO anon
WITH CHECK (true);

CREATE POLICY "Allow authenticated users to view submissions" 
ON public.submissions 
FOR SELECT 
TO authenticated
USING (true);

-- Add basic policies for tickets table (authenticated users only)
CREATE POLICY "Allow authenticated users to view tickets" 
ON public.tickets 
FOR SELECT 
TO authenticated
USING (true);

CREATE POLICY "Allow authenticated users to insert tickets" 
ON public.tickets 
FOR INSERT 
TO authenticated
WITH CHECK (true);